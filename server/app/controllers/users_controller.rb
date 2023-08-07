class UsersController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  before_action :require_authentication, except: :create
  def create
    @user = User.new(user_params)

    if @user.save
      payload = {
        user_id: @user.id,
        exp: Time.now.to_i + 3600*24
      }
      token = JWT.encode(payload, 'your_secret_key', 'HS256')
      render json: {user: @user, token: token}, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find(params[:id])
    render json: {user: @user, articles: @user.articles, followers: @user.followers, following: @user.following, viewed_article: @user.viewed_posts, subscription: @user.subscriptions.last}
  end

  def update
    @user = User.find(@current_user.id)
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

  def require_authentication
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      render json: {error: "invalid token"} if !decoded_token[0]['user_id']
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: header }, status: :unauthorized
    end
  end
end