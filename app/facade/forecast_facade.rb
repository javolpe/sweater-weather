class ForecastFacade 
  def self.forecast_index(location)
    map_data = MapquestService.find_lat_long(location)
    coordinates = Coordinates.new(map_data)
    return "true" if ForecastFacade.bad_coordinates(coordinates) == "true"
    weather = WeatherService.find_current_forecast(coordinates.lat, coordinates.lng)
    forecast = CityWeather.new(weather)
  end

  def self.bad_coordinates(coords)
    if coords.lat == 39.390897 && coords.lng == -99.066067
      "true"
    elsif coords.lat == 0 && coords.lng == 0
      "true"
    else
      "false"
    end
  end
end