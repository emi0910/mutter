class ImagesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :show]

  def index
    @images = Image.paginate(page: params[:page], per_page: 12)
    render partial: 'images/images'
  end

  def show
    @image = Image.find(params[:id])
    redirect_to @image.image.url
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      render plain: "ok"
    else
      render plain: "bad request", status: :bad_request
    end
  end

  private

  def image_params
    params.require(:image).permit(:image)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
