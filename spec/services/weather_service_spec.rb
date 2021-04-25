require 'rails_helper'

RSpec.describe WeatherService, type: :model do 
  describe "happy path" do 
    describe "when given a lat long" do 
      it "returns the current, hourly and daily weather data we need", :vcr do 
        response = WeatherService.find_current_forecast(39.1224, -104.1665)

        expect(response).to be_a(Hash)
        expect(response).to have_key(:current)
        expect(response[:current]).to be_a(Hash)

        expect(response[:current]).to have_key(:dt)
        expect(response[:current][:dt]).to be_an(Integer)

        expect(response[:current]).to have_key(:sunrise)
        expect(response[:current][:sunrise]).to be_an(Integer)

        expect(response[:current]).to have_key(:sunset)
        expect(response[:current][:sunset]).to be_an(Integer)

        expect(response[:current]).to have_key(:temp)
        expect(response[:current][:temp]).to be_a(Float)

        expect(response[:current]).to have_key(:feels_like)
        expect(response[:current][:feels_like]).to be_a(Float).or(be_an Integer)

        expect(response[:current]).to have_key(:humidity)
        expect(response[:current][:humidity]).to be_a(Float).or(be_an Integer).or(be_an Integer)

        expect(response[:current]).to have_key(:uvi)
        expect(response[:current][:uvi]).to be_a(Float).or(be_an Integer)

        expect(response[:current]).to have_key(:visibility)
        expect(response[:current][:visibility]).to be_a(Float).or(be_an Integer)

        expect(response[:current]).to have_key(:weather)
        expect(response[:current][:weather].first).to have_key(:description)
        expect(response[:current][:weather].first[:description]).to be_a(String)
        expect(response[:current][:weather].first).to have_key(:icon)
        expect(response[:current][:weather].first[:icon]).to be_a(String)

        expect(response[:hourly]).to be_an(Array)
        expect(response[:hourly].count).to eq(48)
        expect(response[:hourly].first).to have_key(:dt)
        expect(response[:hourly].first[:dt]).to be_a(Integer)

        expect(response[:hourly].first).to have_key(:temp)
        expect(response[:hourly].first[:temp]).to be_a(Float).or(be_an Integer)

        expect(response[:hourly].first).to have_key(:weather)
        expect(response[:hourly].first[:weather]).to be_an(Array)
        expect(response[:hourly].first[:weather].first).to be_a(Hash)
        expect(response[:hourly].first[:weather].first).to have_key(:description)
        expect(response[:hourly].first[:weather].first[:description]).to be_a(String)

        expect(response[:daily]).to be_an(Array)
        expect(response[:daily].count).to eq(8)
        expect(response[:daily].first).to have_key(:dt)
        expect(response[:daily].first[:dt]).to be_a(Integer)

        expect(response[:daily].first).to have_key(:sunrise)
        expect(response[:daily].first[:sunrise]).to be_an(Integer)

        expect(response[:daily].first).to have_key(:sunset)
        expect(response[:daily].first[:sunset]).to be_an(Integer)
        
        expect(response[:daily].first).to have_key(:temp)
        expect(response[:daily].first[:temp]).to be_a(Hash)
        expect(response[:daily].first[:temp]).to have_key(:max)
        expect(response[:daily].first[:temp]).to have_key(:min)
        
        expect(response[:daily].first).to have_key(:weather)
        expect(response[:daily].first[:weather]).to be_a(Array)
        expect(response[:daily].first[:weather].first).to have_key(:description)
        expect(response[:daily].first[:weather].first[:description]).to be_a(String)
        expect(response[:daily].first[:weather].first).to have_key(:icon)
        expect(response[:daily].first[:weather].first[:icon]).to be_a(String)
      end
    end
  end
end