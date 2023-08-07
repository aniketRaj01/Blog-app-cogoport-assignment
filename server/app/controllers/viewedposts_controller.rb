class ViewedpostsController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  before_action :require_authentication
  
  def create
    posts_viewed = (@current_user.viewed_posts)
    posts_viewed_today = posts_viewed.select{|obj| Date.parse(obj.created_at.to_s) == Date.today}.length
    membership = 0
    if @current_user.subscriptions
      membership = @current_user.subscriptions.last[:membership]
      
    end
    if membership == 1 && posts_viewed_today == 3
      return render json: {msg: "cannot view more posts upgrade membership"}, status: :unauthorized
    elsif membership == 2 && posts_viewed_today == 5
      return render json: {msg: "cannot view more posts upgrade membership"}, status: :unauthorized
    elsif membership == 3 && posts_viewed_today == 10
      return render json: {msg: "cannot view more posts upgrade membership"}, status: :unauthorized
    elsif membership == 0 && posts_viewed_today == 1
      return render json: {msg: "cannot view more posts upgrade membership"}, status: :unauthorized
    end

    if @current_user.viewed_posts.find_by(article_id: post_params[:article_id])
      return render json: {msg: "this article already is already viewed"}, status: :unprocessable_entity
    end
    @viewed_article = ViewedPost.new(user_id: @current_user.id, article_id: post_params[:article_id])
    if @viewed_article.save
      return render json: posts_viewed
    end
  
    render json: @viewed_article.errors.full_messages
  end

  private
  def post_params
    params.require(:viewedpost).permit(:article_id)
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