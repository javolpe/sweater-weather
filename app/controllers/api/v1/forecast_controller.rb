class Api::V1::ForecastController < ApplicationController
  def index 
    return invalid_params if !params[:location] || params[:location] == ""
    @map_data = MapquestService.find_lat_long(params[:location])
    @coordinates = Coordinates.new(@map_data)
    binding
    return invalid_params if bad_coordinates(@coordinates) == "true"
    @weather = WeatherService.find_current_forecast(@coordinates.lat, @coordinates.lng)
    @forecast = CityWeather.new(@weather)
    @serial = ForecastSerializer.new(@forecast)

    render json: @serial
  end

  private


  def bad_coordinates(coords)
    if coords.lat == 39.390897 && coords.lng == -99.066067
      "true"
    elsif coords.lat == 0 && coords.lng == 0
      "true"
    end
  end
end