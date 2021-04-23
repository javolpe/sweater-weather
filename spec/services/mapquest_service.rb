require 'rails_helper'

RSpec.describe MapquestService, type: :model do 
  describe "happy path" do 
    describe "find lat long happy path" do 
      it "should return Denvers lat/lang if given Denver,CO as query params" do 
        response = MapquestService.find_lat_long("denver,co")

        expect(response.class).to eq(Hash)
        expect(response[:results]).to be_an(Array)
        expect(response[:results].first[:locations][:latLng]).to eq("lat": 39.738453, "lng": -104.984853)
      end
    end
  end
end