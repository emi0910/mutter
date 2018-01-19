class ImagesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create]

  def index
    @images = Image.all
    render json: @images
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
end
