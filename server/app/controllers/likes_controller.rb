class LikesController < ApplicationController

  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @like = Like.new(like_params)
    if @like.save
      render json: {like: @like, msg: "post is been liked"}
    else
      render json: @like.errors.full_messages
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      render json: {msg: "removed like"}
    else 
      render json: @like.errors.full_messages
    end
  end
  
  private
  def like_params
    params.require(:like).permit(:user_id, :article_id)
  end
end