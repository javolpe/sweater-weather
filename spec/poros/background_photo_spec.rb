require 'rails_helper'

RSpec.describe BackgroundPhoto do 
  describe 'Poro serialize only data needed for background photo' do 
    it 'should create one poro with the data needed for background photo', :vcr do 
      response = UnsplashService.find_city_photo("denver,co")
      location = "denver,co"

      data = BackgroundPhoto.new(response, location)

      expect(data).to be_a(BackgroundPhoto)
      
      expect(data.id).to be_nil 
      expect(data.image_url).to be_a(String)
      expect(data.location).to eq("denver,co")
      expect(data.credit).to be_a(Hash)
      expect(data.credit.keys.count).to eq(4)
      expect(data.credit[:user_id]).to be_a(String)
      expect(data.credit[:artist]).to be_a(String)
      expect(data.credit[:artist_page]).to be_a(String)
      expect(data.credit[:source]).to be_a(String)
    end
  end
end