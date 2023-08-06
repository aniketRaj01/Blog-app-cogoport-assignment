class FollowingsController < ApplicationController
  before_action :require_authentication
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @existing_following = Following.find_by(user_id: @current_user.id, following_id: followings_params[:following_id])
    
    if @existing_following
      @existing_following.destroy
      return render json: {msg: "unfollowed"}
    end
    @following = Following.new(followings_params)
    @following.user_id = @current_user.id
    if @following.save
      @x = Follower.create(user_id: followings_params[:following_id], follower_id: @current_user.id)
      render json: @x
    else 
      render json: @following.errors.full_messages
    end
  end

  private
  def followings_params
    params.require(:following).permit(:following_id)
  end

  def require_authentication
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      render json: {error: "invalid token"} if !decoded_token[0]['user_id']
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError
      render json: {error: "Unauthorized token" }, status: :unauthorized
    end
  end
end