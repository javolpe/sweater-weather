require 'rails_helper'

RSpec.describe 'API::V1:Backgrounds#Index', type: :request do 
  describe 'happy path' do 
    it 'returns serialized info for the background image if given a location param', :vcr do 

      get api_v1_backgrounds_path, params: {location: "denver,co"}
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:id]).to be_nil 
      expect(json[:data][:type]).to eq("image")
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to be(3)
      expect(json[:data][:attributes][:image_url]).to be_a(String)
      expect(json[:data][:attributes][:location]).to be_a(String)
      expect(json[:data][:attributes][:credit]).to be_a(Hash)
      expect(json[:data][:attributes][:credit].keys.count).to eq(4)
      expect(json[:data][:attributes][:credit][:user_id]).to be_a(String)
      expect(json[:data][:attributes][:credit][:artist]).to be_a(String)
      expect(json[:data][:attributes][:credit][:artist_page]).to be_a(String)
      expect(json[:data][:attributes][:credit][:source]).to be_a(String)
    end
  end
  describe 'sad path' do 
    it 'returns invalid params if params[:location] isnt present', :vcr do 
      get api_v1_backgrounds_path

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      
      expect(json[:error]).to eq("invalid parameters")
    end
    it 'returns invalid params if params[:location] is not a string', :vcr do 
      get api_v1_backgrounds_path, params: {location: ""}

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      
      expect(json[:error]).to eq("invalid parameters")
    end
  end
end