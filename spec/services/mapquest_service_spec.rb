require 'rails_helper'

RSpec.describe MapquestService, type: :model do 
  describe "happy path" do 
    describe "find lat long happy path" do 
      it "should return Denvers lat/lang if given Denver,CO as query params", :vcr do 
        response = MapquestService.find_lat_long("denver,co")

        expect(response.class).to eq(Hash)
        expect(response).to have_key(:results)
        expect(response[:results]).to be_an(Array)
        expect(response[:results].first).to have_key(:locations)
        expect(response[:results].first[:locations]).to be_an(Array)
        expect(response[:results].first[:locations].first).to have_key(:latLng)
        expect(response[:results].first[:locations].first[:latLng]).to be_a(Hash)
        expect(response[:results].first[:locations].first[:latLng]).to have_key(:lat)
        expect(response[:results].first[:locations].first[:latLng]).to have_key(:lng)
        expect(response[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
        expect(response[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      end
    end
  end
end