class CommentsController < ApplicationController
  before_action :require_authentication
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    if @comment.save
      render json: @comment
    else
      render json: @comment.full_messages
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.user_id != @current_user.id
      return render json: {msg: "you are not the author"}
    end
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors.full_messages
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

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id != @current_user.id
      return render json: {msg: "you are not the author"}
    end
    if @comment.destroy
      render json: {msg: "this comment has been deleted"}
    else
      render json: @comment.errors.full_messages
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :article_id)
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