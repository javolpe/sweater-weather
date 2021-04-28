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
    describe "find directions" do 
      it "should return back driving direction data", :vcr do
        starting = "Denver, CO"
        ending = "Tempe, AZ" 
        response = MapquestService.find_driving_directions(starting, ending)

        expect(response).to be_a(Hash)
        expect(response[:route]).to be_a(Hash)
        expect(response[:route][:routeError][:errorCode]).to eq(-400)
        expect(response[:route]).to have_key(:formattedTime)
        expect(response[:route][:formattedTime]).to be_a(String)
        expect(response[:route]).to have_key(:boundingBox)
        expect(response[:route][:boundingBox]).to be_a(Hash)
        expect(response[:route][:boundingBox]).to have_key(:ul)
        expect(response[:route][:boundingBox][:ul]).to be_a(Hash)
        expect(response[:route][:boundingBox][:ul]).to have_key(:lng)
        expect(response[:route][:boundingBox][:ul]).to have_key(:lat)
        expect(response[:route][:boundingBox][:ul][:lat]).to be_a(Float)
        expect(response[:route][:boundingBox][:ul][:lng]).to be_a(Float)
      end
    end
    describe 'sad path' do 
      it 'returns routeError 2 if route is impossible', :vcr do 
        starting = "Denver, CO"
        ending = "Tokyo" 
        response = MapquestService.find_driving_directions(starting, ending)

        expect(response).to be_a(Hash)
        expect(response[:route]).to be_a(Hash)
        expect(response[:route]).to have_key(:routeError)
        expect(response[:route][:routeError]).to be_a(Hash)
        expect(response[:route][:routeError]).to have_key(:errorCode)
        expect(response[:route][:routeError][:errorCode]).to eq(2)
      end
    end
  end
end