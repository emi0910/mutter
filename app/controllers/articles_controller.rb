class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy]

  def show
    @article = Article.find(params[:id])
    logged_in_user unless @article.public?
  end

  def new
    @article = Article.new(content: "<!-- folding -->")
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :public)
  end
end
