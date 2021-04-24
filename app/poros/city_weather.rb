class CityWeather 
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather 

  def initialize(data)
    @id = id
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = format_daily_weather(data[:daily])
    @hourly_weather = format_hourly_weather(data[:hourly])
  end

  def format_daily_weather(data)
    five_day = data.first(5)
    five_day.map{|day| DailyWeather.new(day)}
  end

  def format_hourly_weather(data)
    eight_hour = data.first(8)
    eight_hour.map{|hour| HourlyWeather.new(hour)}
  end
end