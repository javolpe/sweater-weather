class Api::V1::BackgroundsController < ApplicationController
  def index 
    return invalid_params if !params[:location] || params[:location] == ""
    @serial = BackgroundsFacade.background_index(params[:location])
    render json: @serial
  end
end