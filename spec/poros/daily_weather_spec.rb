require 'rails_helper'

RSpec.describe DailyWeather do 
  describe 'daily weather poro' do 
    it 'should create a daily hourly weather poro' do 
      data = test_daily_poro

      daily_data = DailyWeather.new(data)

      expect(daily_data.date).to be_a(String)
      expect(daily_data.sunrise).to be_a(String)
      expect(daily_data.sunset).to be_a(String)
      expect(daily_data.max_temp).to be_a(Numeric)
      expect(daily_data.min_temp).to be_a(Numeric)
      expect(daily_data.conditions).to be_a(String)
      expect(daily_data.icon).to be_a(String)

    end
  end
end