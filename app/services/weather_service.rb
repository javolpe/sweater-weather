class WeatherService 
  def self.conn 
    connection = Faraday.new(url: "https://api.openweathermap.org") do |req|
      req.params['appid'] = ENV['WEATHER_KEY']
    end
  end 

  def self.find_current_forecast(lattitude, longitude, exclude = 'minutely', lang = 'en', units = 'imperial') 
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = lattitude
      req.params['lon'] = longitude
      req.params['exclude'] = exclude
      req.params['units'] = units
      req.params['lang'] = lang
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end