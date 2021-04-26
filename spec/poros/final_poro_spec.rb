require 'rails_helper'

RSpec.describe FinalPoro do 
  describe 'Parent poro to return destination, forecast, salaries' do
    it 'should create one poro with all data needed for a major city' do 
      destination = "miami"
      response_1 = SalaryService.find_urban_area_salaries(destination)
      response_2 = WeatherService.find_current_forecast(39.1224, -104.1665)


      data = FinalPoro.new(response_1, response_2, destination)

      expect(data.class).to eq(FinalPoro)
      expect(data.id).to be_nil
      expect(data.forecast).to be_a(Hash)
      expect(data.forecast).to have_key(:summary)
      expect(data.forecast).to have_key(:temperature)
      expect(data.forecast[:summary]).to be_a(String)
      expect(data.forecast[:temperature]).to be_a(String)

      expect(data.salaries).to be_an(Array)
      expect(data.salaries.count).to eq(7)
      expect(data.salaries.first.max).to be_a(String)
      expect(data.salaries.first.min).to be_a(String)
      expect(data.salaries.first.title).to be_a(String)
      
    end
  end
end