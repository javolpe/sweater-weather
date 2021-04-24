require 'rails_helper'

RSpec.describe DailyWeather do 
  describe 'daily weather poro' do 
    it 'should create a daily hourly weather poro' do 
      data = {
        "dt": 1619287200,
        "sunrise": 1619266002,
        "sunset": 1619314946,
        "moonrise": 1619305140,
        "moonset": 1619262060,
        "moon_phase": 0.41,
        "temp": {
            "day": 50.43,
            "min": 36.63,
            "max": 62.82,
            "night": 53.49,
            "eve": 61.48,
            "morn": 38.41
        },
        "feels_like": {
            "day": 47.62,
            "night": 32.23,
            "eve": 58.55,
            "morn": 32.23
        },
        "pressure": 1013,
        "humidity": 52,
        "dew_point": 33.49,
        "wind_speed": 20.42,
        "wind_deg": 192,
        "wind_gust": 20.56,
        "weather": [
            {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02d"
            }
        ],
        "clouds": 13,
        "pop": 0,
        "uvi": 6.89
    }


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