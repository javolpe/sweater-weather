class Api::V1::ForecastController < ApplicationController
  def index 
    @coordinates = MapquestService.find_lat_long(index_params)
    @weather = WeatherService.find_current_forecast(@coordinates[:results].first[:locations].first[:latLng][:lat], @coordinates[:results].first[:locations].first[:latLng][:lng])
    @forecast = CityWeather.new(@weather)
    @serial = ForecastSerializer.new(@forecast)

    render json: @serial
  end

  private

  def index_params 
    params.permit(:location)
  end
end