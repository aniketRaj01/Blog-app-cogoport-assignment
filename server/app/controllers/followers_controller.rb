class FollowersController < ApplicationController
  before_action :require_authentication
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def destroy
    @follower = Follower.find_by(user_id: @current_user.id, follower_id: followers_params["follower_id"])
    if !@follower
      return render json: {msg: "no follower exists"}
    end
    if @follower.destroy
      render json: {msg: "unfollowed"} 
    else
      render json: @follower.errors.full_messages
    end
  end
  
  private 
  def followers_params
    params.require(:follower).permit(:follower_id)
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