class RoadTripFacade 
  def self.create_road_trip(origin, destination)
    directions = MapquestService.find_driving_directions(origin, destination)
    if directions[:route][:routeError][:errorCode] == -400
      destination_data = DestinationData.new(directions)
      return "true" if RoadTripFacade.bad_coordinates(destination_data) == "true"
      weather = WeatherService.find_current_forecast(destination_data.lat, destination_data.lng)
      road_trip_data = RoadTripData.new(origin, destination, weather, destination_data)
    else 
      impossible_road_trip = ImpossibleRoadTrip.new(origin, destination)
    end
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