require 'rails_helper'

RSpec.describe DailyWeather do 
  describe 'daily weather poro' do 
    it 'should create a daily hourly weather poro' do 
      data = test_current_poro

      current_data = CurrentWeather.new(data)

      expect(current_data.datetime).to be_a(String)
      expect(current_data.sunrise).to be_a(String)
      expect(current_data.sunset).to be_a(String)
      expect(current_data.temperature).to be_a(Numeric)
      expect(current_data.feels_like).to be_a(Numeric)
      expect(current_data.humidity).to be_a(Numeric)
      expect(current_data.uvi).to be_a(Numeric)
      expect(current_data.visibility).to be_a(Integer)
      expect(current_data.conditions).to be_a(String)
      expect(current_data.icon).to be_a(String)
    end
  end
end