require 'rails_helper'

RSpec.describe HourlyWeather do 
  describe 'hourly weather poro' do 
    it 'should create a singly hourly weather poro' do 
      data = {
        "dt": 1619276400,
        "temp": 47.43,
        "feels_like": 41.02,
        "pressure": 1015,
        "humidity": 63,
        "dew_point": 35.47,
        "uvi": 2.1,
        "clouds": 2,
        "visibility": 10000,
        "wind_speed": 16.33,
        "wind_deg": 197,
        "wind_gust": 21.5,
        "weather": [
            {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
            }
            ],
            "pop": 0
        }

        hourly_data = HourlyWeather.new(data)

        expect(hourly_data.time).to eq("09:00:00")
        expect(hourly_data.time).to be_a(String)

        expect(hourly_data.temperature).to eq(47.43)
        expect(hourly_data.temperature).to be_a(Float)

        expect(hourly_data.conditions).to eq("clear sky")
        
        expect(hourly_data.icon).to eq("01d")
    end
  end
end