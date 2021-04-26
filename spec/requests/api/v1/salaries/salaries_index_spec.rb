require 'rails_helper'

RSpec.describe 'API::V1::Salaries#Inddex', type: :request do 
  describe 'happy path' do 
    xit 'returns destination, current weather, and salary info including job titles and min/max' do 

      get api_v1_salaries_path, params: {destination: "miami"}

    end
    end
  end