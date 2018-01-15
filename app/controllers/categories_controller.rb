class CategoriesController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 6)
  end

  def show
    @category = Category.find(params[:id])
    @articles = (logged_in? ? @category.articles : @category.articles.publicized).take(3)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was successfully created."
      redirect_to @category
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category was updated"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category was deleted"
    redirect_to categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name, :image, :description, :image_cache)
  end
end
