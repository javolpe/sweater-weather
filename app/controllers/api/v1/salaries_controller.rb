class Api::V1::SalariesController < ApplicationController 
  def index 
    return invalid_params if !params[:destination] || params[:destination] == ""
    @map_data = MapquestService.find_lat_long(params[:destination])
    @coordinates = Coordinates.new(@map_data)
    @weather = WeatherService.find_current_forecast(@coordinates.lat, @coordinates.lng)
    @raw_salary_info = SalaryService.find_urban_area_salaries(params[:destination])
    @final = FinalPoro.new(@raw_salary_info, @weather, params[:destination])
    @serial = SalariesSerializer.new(@final)
    
    render json: @serial
  end
end