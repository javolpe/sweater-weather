require 'rails_helper'

RSpec.describe UnsplashService, type: :model do 
  describe "happy path" do 
    describe "find a photo of a city" do 
      it "should return a photo url based on the location param sent in", :vcr do 
        response = UnsplashService.find_city_photo("denver,co")

        expect(response).to be_a(Hash)
        expect(response[:total]).to be > 1
        expect(response).to have_key(:results)
        expect(response[:results]).to be_an(Array)
        expect(response[:results].first).to be_a(Hash)
        expect(response[:results].first).to have_key(:urls)
        expect(response[:results].first[:urls]).to be_a(Hash)
        expect(response[:results].first[:urls]).to have_key(:regular)
        expect(response[:results].first[:urls][:regular]).to be_a(String)
        expect(response[:results].first[:user]).to be_a(Hash)
        expect(response[:results].first[:user]).to have_key(:id)
        expect(response[:results].first[:user][:id]).to be_a(String)
        expect(response[:results].first[:user]).to have_key(:name)
        expect(response[:results].first[:user][:name]).to be_a(String)
        expect(response[:results].first[:user][:links]).to be_a(Hash)
        expect(response[:results].first[:user][:links]).to have_key(:html)
        expect(response[:results].first[:user][:links][:html]).to be_a(String)
      end
    end
  end
end