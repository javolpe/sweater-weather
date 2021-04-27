require 'rails_helper'

RSpec.describe DestinationData  do 
  describe 'road trip poro' do 
    it 'should create a road trip poro and format data how I want it', :vcr do 
      raw_data = MapquestService.find_driving_directions("denver,co", "tempe, az")

      data = DestinationData.new(raw_data)

      expect(data.travel_time).to be_a(String)
      expect(data.lat).to be_a(Float)
      expect(data.lng).to be_a(Float)
    end
  end
end