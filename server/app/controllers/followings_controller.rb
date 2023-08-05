class FollowingsController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @following = Following.new(followings_params)
    if @following.save
      render json: @following
    else 
      render json: @following.errors.full_messages
    end
  end

  def destroy
    @following = Following.find(params[:id])
    if @following.destroy
      render json: {msg: "unfollowed"}
    else
      render json: @following.errors.full_messages
    end
  end

  private
  def followings_params
    params.require(:following).permit(:user_id, :following_id)
  end
end