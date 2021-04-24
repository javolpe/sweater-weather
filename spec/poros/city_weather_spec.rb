require 'rails_helper'

RSpec.describe CityWeather do 
  describe 'Master poro that contains the three other poros needed for a citys weather' do 
    it 'should create one poro with 4 attributes total containg all day FE needs', :vcr do 
      response = WeatherService.find_current_forecast(39.1224, -104.1665)

      data = CityWeather.new(response)

      expect(data.id).to be_nil

      expect(data.current_weather).to be_a(CurrentWeather)

      expect(data.daily_weather).to be_an(Array)
      expect(data.daily_weather.count).to eq(5)
      expect(data.daily_weather.first).to be_a(DailyWeather)

      expect(data.hourly_weather).to be_an(Array)
      expect(data.hourly_weather.count).to eq(8)
      expect(data.hourly_weather.first).to be_a(HourlyWeather)
    end
  end
end