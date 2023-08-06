class LikesController < ApplicationController
  before_action :require_authentication
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  def create
    @existing_like = Like.find_by(user_id: @current_user.id, article_id: like_params[:article_id])
    if @existing_like
      @existing_like.destroy
      return  render json: {msg: "unliked"}
    end
    @like = Like.new(like_params)
    @like.user_id = @current_user.id
    if @like.save
      render json: {msg: "post is been liked"}
    else
      render json: @like.errors.full_messages
    end
  end

  private
  def like_params
    params.require(:like).permit(:article_id)
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