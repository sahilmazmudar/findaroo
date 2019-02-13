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
  	if params[:get_matches] == "true" && params[:priorityList]
  	  matches = getMatches(@user.id, params[:priorityList]) 
  	  if params[:send_matches] == "true"
  	  	emails = []
  	  	matches.each do |match|
  	  		emails.push(match.email)
  	  	end
  	  	NotifierMailer.mailgun_send(emails).deliver_now
  	  end
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
end
