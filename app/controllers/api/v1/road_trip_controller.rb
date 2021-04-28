class Api::V1::RoadTripController < ApplicationController
  def create 
    return unauthorized if !params[:api_key] || User.where(api_key: params[:api_key]).empty?
    return invalid_params if !params[:destination] || !params[:origin]
    road_trip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
    return invalid_params if road_trip == "true"
    @serial = RoadtripSerializer.new(road_trip)
    render json: @serial
  end 
end