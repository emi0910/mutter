class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]
  before_action :set_article, only: :show
  before_action :auth_if_private_article, only: :show
  before_action :count_up, only: :show

  def index
    paginate_options = { page: params[:page], per_page: 6}
    @articles = current_user ? Article.paginate(paginate_options) : Article.publicized.paginate(paginate_options)
  end

  def show
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to @article
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :public, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def auth_if_private_article
    logged_in_user unless @article.public?
  end

  def count_up
    @article.update_attribute(:count, @article.count + 1)
  end
end
