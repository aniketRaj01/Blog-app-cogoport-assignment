
class RecommendationsController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  before_action :require_authentication, except: :create
  def show
    render json: recommend_articles()
  end

  private

  def recommend_articles()
    score_list = []
    all_articles = Article.all
    read_articles = @current_user.viewed_posts
    all_articles.each do |article|
      read_articles.each do |read_article|
        if article.id != read_article.id
          article_with_score = {article: article, score: 0}
          article_with_score[:score] = get_score(article, read_article)
          score_list << article_with_score
        end
      end
    end
    return score_list.sort_by!{|obj| obj[:score]}
  end
  
  def get_score(article, read_article)
    
    article_array = (article[:description] + article[:title]).split(" ") if article[:description] && article[:title]
    read_article_array = (read_article[:description] + read_article[:title]).split(" ") if read_article[:description] && read_article[:title]
    score = 0
    if article_array && read_article_array
      read_article_array.each do |first|
        score += article_array.count(first)
      end
    end
    return score
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