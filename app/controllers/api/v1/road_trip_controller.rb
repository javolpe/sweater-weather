class Api::V1::RoadTripController < ApplicationController
  def create 
    return unauthorized if !params[:api_key] || User.where(api_key: params[:api_key]).empty?
    return invalid_params if !params[:destination] || !params[:origin]
    @directions = MapquestService.find_driving_directions(params[:origin], params[:destination])
    @destination_data = DestinationData.new(@directions)
    @coordinates = Coordinates.new(@destination_data)
    # return invalid_params if bad_coordinates(@coordinates) == "true"
    @weather = WeatherService.find_current_forecast(@coordinates.lat, @coordinates.lng)
    @road_trip_data = RoadTripData.new(params[:origin], params[:destination], @weather, @destination_data)
    @serial = RoadtripSerializer.new(@road_trip_data)
    
    render json: @serial
  end

  def bad_coordinates(coords)
    if coords.lat == 39.390897 && coords.lng == -99.066067
      "true"
    elsif coords.lat == 0 && coords.lng == 0
      "true"
    end
  end
end