class ImpossibleRoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
      
  def initialize(origin, destination)
    @start_city = origin 
    @end_city = destination 
    @travel_time = "Impossible!"
    @weather_at_eta = {}
  end
end