class Api::V1::ForecastController < ApplicationController
  def index 
    return invalid_params if !params[:location] || params[:location] == ""
    forecast = ForecastFacade.forecast_index(params[:location])
    return invalid_params if forecast == "true"
    @serial = ForecastSerializer.new(forecast)
    render json: @serial
  end
end