require 'rails_helper'

RSpec.describe HourlyWeather do 
  describe 'hourly weather poro' do 
    it 'should create a singly hourly weather poro' do 
      data = test_hourly_poro

      hourly_data = HourlyWeather.new(data)

      expect(hourly_data.time).to be_a(String)
      expect(hourly_data.time).to be_a(String)

      expect(hourly_data.temperature).to be_a(Float).or(be_an Integer)
      expect(hourly_data.temperature).to be_a(Float).or(be_an Integer)

      expect(hourly_data.conditions).to be_a(String)
      
      expect(hourly_data.icon).to be_a(String)
    end
  end
end