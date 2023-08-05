class UsersController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find(params[:id])
    render json: {user: @user, articles: @user.articles}
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages
    end
  end

  def index
    @users = User.all
    user_list = []
    @users.each do |user|
      user_list << {"author": user, "followers": user.followers, "followings": user.following}
    end
    render json: user_list
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password_digest)
  end
end