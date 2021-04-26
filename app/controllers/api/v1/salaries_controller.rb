class API::V1::SalariesController < ApplicationController 
  def index 
    return invalid_params if !params[:destination] || params[:destination] == ""
    @map_data = MapquestService.find_lat_long(params[:destination])
    @coordinates = Coordinates.new(@map_data)
    @weather = WeatherService.find_current_forecast(@coordinates.lat, @coordinates.lng)
  end
end