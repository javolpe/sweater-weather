class RoadTripData 
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, weather, arrival_data)
    @id = id
    @start_city = origin 
    @end_city = destination 
    @travel_time = format_travel_time(arrival_data)
    @weather_at_eta = find_weather_at_eta(weather, arrival_data)
  end

  def format_travel_time(arrival_data)
    split = arrival_data.travel_time.split(":")
    "#{split[0]} hours, #{split[1]} minutes"
  end

  def find_weather_at_eta(weather, arrival_data)
    split = arrival_data.travel_time.split(":")
    travel_time_in_seconds = (split[0].to_i * 3600) + (split[1].to_i * 60)
    current_time_at_destination = Time.at(weather[:current][:dt])
    arrival_time = current_time_at_destination + travel_time_in_seconds
    travel_hours = split[0].to_i
    forecast = find_weather(weather, travel_hours, arrival_time)
  end

  def find_weather(weather, travel_hours, arrival_time)
    if travel_hours > 167
      {temperature: "more than 7 days, no data available",
        conditions: "more than 7 days, no data available"}
    elsif travel_hours  < 47
      weather = weather[:hourly].find do |hour|
        Time.at(hour[:dt]) > arrival_time
      end
      {temperature: weather[:temp],
       conditions: weather[:weather].first[:description]}
    else  
      weather = weather[:daily].find do |hour|
        Time.at(hour[:dt]) > arrival_time
      end
      {temperature: weather[:temp][:day],
        conditions: weather[:weather].first[:description]}
    end
  end

end