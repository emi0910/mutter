class ImagesController < ApplicationController
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
