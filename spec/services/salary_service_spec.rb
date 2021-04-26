require 'rails_helper'

RSpec.describe SalaryService, type: :model do 
  describe "happy path" do 
    describe "when given a city" do 
      it "returns the salary data we need" do 
        response = SalaryService.find_urban_area_salaries("miami")

        binding.pry
      end
    end
  end
end