class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :destroy, :preview]
  before_action :set_article, only: :show
  before_action :auth_if_private_article, only: :show
  before_action :count_up, only: :show

  def index
    paginate_options = { page: params[:page], per_page: 6}
    @articles = narrow_articles.paginate(paginate_options)
  end

  def show
  end

  def new
    @article = Article.new
    @categories = Category.all
    @image = Image.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      notify_to_slack
      flash[:success] = "Article was successfully created."
      redirect_to @article
    else
      @categories = Category.all
      @image = Image.new
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all
    @image = Image.new
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article was updated"
      redirect_to @article
    else
      @categories = Category.all
      @image = Image.new
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article was deleted"
    redirect_to articles_url
  end

  def preview
    title = "<h2>#{article_params[:title]}</h2>"
    clear = "<div class='clear'></div>"
    render plain: title + Kramdown::Document.new(article_params[:content],
                                                 input: "GFM").to_html + clear
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

  def narrow_articles
    articles = (logged_in? ? Article : Article.publicized)
    articles = articles.created_by(params[:user_id]) if params[:user_id]
    articles = articles.belong_to(params[:category_id]) if params[:category_id]
    articles
  end

  def notify_to_slack
    if (url = Settings.SLACK_INCOMING_WEBHOOK_URL)
      client = SlackNotifier.new(url)
      client.post_article(@article, {article: article_url(@article), user: user_url(@article.user)})
    end
  end
end
