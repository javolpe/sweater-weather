require 'rails_helper'

RSpec.describe SalaryService, type: :model do 
  describe "happy path" do 
    describe "when given a city" do 
      it "returns the salary data we need" do 
        response = SalaryService.find_urban_area_salaries("miami")

        expect(response).to be_an(Array)
        expect(response.first).to be_a(Hash)
        expect(response.first).to have_key(:job)
        expect(response.first[:job]).to be_a(Hash)
        expect(response.first[:job].keys.count).to eq(2)
        expect(response.first[:job][:id]).to be_a(String)
        expect(response.first[:job][:title]).to be_a(String)
        expect(response.first[:salary_percentiles]).to have_key(:percentile_25)
        expect(response.first[:salary_percentiles]).to have_key(:percentile_50)
        expect(response.first[:salary_percentiles]).to have_key(:percentile_75)
        expect(response.first[:salary_percentiles][:percentile_25]).to be_a(Float)
      end
    end
  end
end