require 'rails_helper'

RSpec.describe DailyWeather do 
  describe 'daily weather poro' do 
    it 'should create a daily hourly weather poro' do 
      data = test_daily_poro

      daily_data = DailyWeather.new(data)

      expect(daily_data.date).to eq("2021-04-24")
      expect(daily_data.sunrise).to eq("2021-04-24 06:06:42 -0600")
      expect(daily_data.sunset).to eq("2021-04-24 19:42:26 -0600")
      expect(daily_data.max_temp).to eq(62.82)
      expect(daily_data.min_temp).to eq(36.63)
      expect(daily_data.conditions).to eq("few clouds")
      expect(daily_data.icon).to eq("02d")

    end
  end
end