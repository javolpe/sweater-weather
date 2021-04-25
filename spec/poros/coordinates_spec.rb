require 'rails_helper'

RSpec.describe Coordinates do 
  describe 'coordinates poro' do 
    it "changes the map data into lat and long", :vcr do 
      data = MapquestService.find_lat_long("boulder,co")

      coordinates = Coordinates.new(data)

      expect(coordinates.lat).to eq(40.015831)
      expect(coordinates.lng).to eq(-105.27927)
    end
  end
end