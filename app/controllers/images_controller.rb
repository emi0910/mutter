class ImagesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create]

  def index
    @images = Image.paginate(page: params[:page], per_page: 12)
    render partial: 'images/images'
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      render
    else
      render
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
