class FollowersController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @follower = Follower.new(followers_params)
    if @follower.save
      render json: @follower
    else 
      render json: @follower.errors.full_messages
    end
  end

  def destroy
    @follower = Follower.find(params[:id])
    if @follower.destroy
      render json: {msg: "unfollowed"}
    else
      render json: @follower.errors.full_messages
    end
  end
  private
  def followers_params
    params.require(:follower).permit(:user_id, :follower_id)
  end
end