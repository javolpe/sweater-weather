require 'rails_helper'

RSpec.describe 'API::V1::Salaries#Inddex', type: :request do 
  describe 'happy path' do 
    it 'returns destination, current weather, and salary info including job titles and min/max' do 

      get api_v1_salaries_path, params: {destination: "miami"}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:id]).to be_nil 
      expect(json[:data][:type]).to eq("salaries")

      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to be(3)
      expect(json[:data][:attributes]).to have_key(:destination)
      expect(json[:data][:attributes]).to have_key(:forecast)
      expect(json[:data][:attributes]).to have_key(:salaries)

      expect(json[:data][:attributes][:destination]).to be_a(String)
      expect(json[:data][:attributes][:destination]).to eq("miami")

      expect(json[:data][:attributes][:forecast]).to be_a(Hash)
      expect(json[:data][:attributes][:forecast]).to have_key(:summary)
      expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(json[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(json[:data][:attributes][:salaries]).to be_an(Array)
      expect(json[:data][:attributes][:salaries].count).to be <= 7
      expect(json[:data][:attributes][:salaries].first.keys.count).to eq(3)
      expect(json[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(json[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(json[:data][:attributes][:salaries].first[:max]).to be_a(String)
    end
  end
  describe 'sad path' do
    it 'returns invalid params if params[:location] isnt present', :vcr do 
      get api_v1_salaries_path

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      
      expect(json[:error]).to eq("invalid parameters")
    end
    it 'returns invalid params if params[:location] is not a string', :vcr do 
      get api_v1_salaries_path, params: {location: ""}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      
      expect(json[:error]).to eq("invalid parameters")
    end
  end
end