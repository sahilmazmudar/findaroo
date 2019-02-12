class UsersController < ApplicationController
  def index
  	@users = User.all
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

  def show
  	@users = User.find(params[:id])
  end
end
