require 'rails_helper'

RSpec.describe WeatherService, type: :model do 
  describe "happy path" do 
    describe "when given a lat long" do 
      it "returns the current, hourly and daily weather data we need" do 
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
        expect(response[:current][:feels_like]).to be_a(Float)

        expect(response[:current]).to have_key(:humidity)
        expect(response[:current][:humidity]).to be_an(Integer)

        expect(response[:current]).to have_key(:uvi)
        expect(response[:current][:uvi]).to be_a(Float)

        expect(response[:current]).to have_key(:visibility)
        expect(response[:current][:visibility]).to be_an(Integer)

        expect(response[:current]).to have_key(:weather)
        expect(response[:current][:weather].first).to have_key(:description)
        expect(response[:current][:weather].first[:description]).to be_a(String)
        expect(response[:current][:weather].first).to have_key(:icon)
        expect(response[:current][:weather].first[:icon]).to be_a(String)
      end
    end
  end
end