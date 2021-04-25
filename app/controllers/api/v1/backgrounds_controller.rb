class Api::V1::BackgroundsController < ApplicationController
  def index 
    return invalid_params if !params[:location] || params[:location] == ""
    @image_info = UnsplashService.find_city_photo(params[:location])
    @photo = BackgroundPhoto.new(@image_info, params[:location])
    @serial = ImageSerializer.new(@photo)

    render json: @serial
  end
end