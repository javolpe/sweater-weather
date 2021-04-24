class HourlyWeather 
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = format_hour(data[:dt])
    @temperature = data[:temp]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end

  def format_hour(time)
    hour = Time.at(time)
    hour.strftime("%H:%M:%S")
  end
end