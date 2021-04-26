require 'rails_helper'

RSpec.describe SalaryBreakdown do
  describe 'salary breakdown poro' do 
    it 'should create a single salary breakdown poro' do 
      data = {:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"},
      :salary_percentiles=>{:percentile_25=>40198.44526917638, :percentile_50=>48379.28467146816, :percentile_75=>58225.017650562215}}

     salary_data = SalaryBreakdown.new(data)

     expect(salary_data.title).to eq("Data Analyst")
     expect(salary_data.min).to eq("$40198.45")
     expect(salary_data.max).to eq("$58225.02")
    end
  end
end
