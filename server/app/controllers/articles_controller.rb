class ArticlesController < ApplicationController

  

  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  def index
    @articles = Article.all
    render json: @articles
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end
   
  def create
    puts 'running'*10
    # params.require(:article).permit(:title, :description)
    @article = Article.new(title:'this is new article',description:'new description')
    @article.save
    render json: {message:'sucessfully created'},status: :created
    # if @article.save
    #   flash[:notice] = "Article was created successfully."
    #   redirect_to @article 
    # else
    #   render 'new'
    # end
  end
  # this code working
  
  # protect_from_forgery with: :null_session # For APIs, we disable CSRF protection

  # def create
  #   @article = Article.new(article_params)

  #   if @article.save
  #     render json: { message: 'Successfully created',title:'do' }, status: :created
  #   else
  #     render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # private

  # def article_params
  #   params.require(:article).permit(:title, :description)
  # end
  # # config/application.rb or config/initializers/cors.rb
  
  # def destroy
  #   @article = Article.find(params[:id])
  #   @article.destroy
  #   redirect_to articles_path
  # end
end