require 'rails_helper'

RSpec.describe DailyWeather do 
  describe 'daily weather poro' do 
    it 'should create a daily hourly weather poro' do 
      data = {
        "dt": 1619278584,
        "sunrise": 1619266002,
        "sunset": 1619314946,
        "temp": 47.91,
        "feels_like": 41.97,
        "pressure": 1015,
        "humidity": 64,
        "dew_point": 36.34,
        "uvi": 3.68,
        "clouds": 3,
        "visibility": 10000,
        "wind_speed": 15.01,
        "wind_deg": 195,
        "wind_gust": 25.01,
        "weather": [
            {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
            }
        ]
    }

      current_data = CurrentWeather.new(data)

      expect(current_data.datetime).to eq("2021-04-24 09:36:24 -0600")
      expect(current_data.sunrise).to eq("2021-04-24 06:06:42 -0600")
      expect(current_data.sunset).to eq("2021-04-24 19:42:26 -0600")
      expect(current_data.temperature).to eq(47.91)
      expect(current_data.feels_like).to eq(41.97)
      expect(current_data.humidity).to eq(64)
      expect(current_data.uvi).to eq(3.68)
      expect(current_data.visibility).to eq(10000)
      expect(current_data.conditions).to eq("clear sky")
      expect(current_data.icon).to eq("01d")
    end
  end
end