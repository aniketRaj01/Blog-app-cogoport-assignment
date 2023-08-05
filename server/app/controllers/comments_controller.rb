class CommentsController < ApplicationController

  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.full_messages
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors.full_messages
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render json: {msg: "this comment has been deleted"}
    else
      render json: @comment.errors.full_messages
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :user_id, :article_id)
  end
end