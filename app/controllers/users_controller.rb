class UsersController < ApplicationController
  respond_to :json

  # GET /users
  def index
  	@users = User.all
  end

  # GET /users/:id
  def show
  	@user = User.find(params[:id])
  	matches = []
  	if params[:get_match] == "true" && params[:priorityList]
  	  matches = getMatches(@user.id, params[:priorityList])  
  	end
  	respond_to do |format|
  		response = {status: 200, message: "Here are your matches!", matches: matches}
  		format.html {render 'show', locals: {matches: matches}}
  		format.json {render json: response}
  	end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user].permit(:name, :email, :budget, :lease_duration, :smoking, :drinking, :cleanliness, :quietness))
  	if @user.save
  		redirect_to new_user_path, alert: "User created successfully!"
  	else
  		redirect_to new_user_path, alert: "User creation failed. Please try again."
  	end
  end

  def getMatches(userId, priorityList)
		targetUser = User.find(userId)
		matches = User.all
		puts matches.size
		puts priorityList.first

		priorityList.each do |category|
			case category
			when "smoking"
				matches = getMatchesForBooleanCategory(userId, "smoking", matches)
 			when "drinking"
 				matches = getMatchesForBooleanCategory(userId, "drinking", matches)
 			when "budget" 
 				matches = getMatchesForNumericalCategory(userId, "budget", 200, matches)
 			when "lease_duration"
 				matches = getMatchesForNumericalCategory(userId, "lease_duration", 1, matches)
 			when "quietness"
 				matches = getMatchesForNumericalCategory(userId, "quietness", 1, matches)
 			when "cleanliness"
 				matches = getMatchesForNumericalCategory(userId, "cleanliness", 1, matches)
			end
		end
		
		matches
	end

	def getMatchesForNumericalCategory(userId, category, tolerance, users)
		targetUser = User.find(userId)
		targetValue = targetUser.attributes[category]
		puts users.first.name
		matches = []

		users.each do |user|
			puts user.name
			if user != targetUser
				if withinTolerance(user, targetUser, category, tolerance)
					matches.push(user)
				end
			end
		end
		matches
	end

	def getMatchesForBooleanCategory(userId, category, users)
		targetUser = User.find(userId)
		targetValue = targetUser.attributes[category]
		matches = []

		users.each do |user|
			if user != targetUser
				if user.attributes[category] == targetValue
					matches.push(user)
				end
			end
		end
		matches
	end

	def withinTolerance(user, targetUser, category, tolerance)
		puts user.attributes[category]
		puts targetUser.attributes[category]
		user.attributes[category].between?(targetUser.attributes[category] - tolerance, targetUser.attributes[category] + tolerance)
	end
end
