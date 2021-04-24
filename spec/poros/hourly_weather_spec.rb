require 'rails_helper'

RSpec.describe HourlyWeather do 
  describe 'hourly weather poro' do 
    it 'should create a singly hourly weather poro' do 
      data = test_hourly_poro

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