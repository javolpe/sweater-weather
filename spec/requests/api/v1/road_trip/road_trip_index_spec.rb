require 'rails_helper'

RSpec.describe 'API::V1::RoadTrip#Create', type: :request do
   before :each do 
    @user_1 = User.create({
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    })
   end
  describe 'happy path' do 
    it 'trip LESS than 47 hours returns origin, destination, travel time, arrival forecast with good params', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "Buffalo, NY", destination: "Asheville, NC", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(json).to be_a(Hash)
      expect(json[:id]).to be_nil
      expect(json[:data][:type]).to eq("roadtrip")
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to eq(4)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta].keys.count).to eq(2)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float).or(be_an Integer)
      expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
    it 'trip MORE than 47 hours but less than 167 returns origin, destination, travel time, arrival forecast with good params', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "Anchorage, AK", destination: "Miami, FL", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(json).to be_a(Hash)
      expect(json[:id]).to be_nil
      expect(json[:data][:type]).to eq("roadtrip")
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to eq(4)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta].keys.count).to eq(2)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float).or(be_an Integer)
      expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
    it 'trip more than 167 hours returns origin, destination, travel time, arrival forecast with good params', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England", destination: "Cape Town, South Africa", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
      expect(json).to be_a(Hash)
      expect(json[:id]).to be_nil
      expect(json[:data][:type]).to eq("roadtrip")
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to eq(4)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta].keys.count).to eq(2)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
    it 'returns travel time is impossible if not possible to drive', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England", destination: "Miami, FL", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)

      expect(json).to be_a(Hash)
      expect(json[:id]).to be_nil
      expect(json[:data][:type]).to eq("roadtrip")
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to eq(4)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:travel_time]).to eq("Impossible!")
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    end
  end
  describe 'sad path' do 
    it 'returns unauthorized if a bad api_key is passed in', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England", destination: "Miami, FL", api_key: 1}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(401)
      expect(json[:error]).to eq("unauthorized request")
    end
    it 'returns unauthorized if no api_key is passed in', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England", destination: "Miami, FL"}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(401)
      expect(json[:error]).to eq("unauthorized request")
    end
    it 'returns invalid if no destination is given', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England",  api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(400)
      expect(json[:error]).to eq("invalid parameters")
    end
    it 'returns invalid if no origin is given', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {destination: "London, England",  api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(400)
      expect(json[:error]).to eq("invalid parameters")
    end
    xit 'returns invalid if word salad is given', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "eageagaegeageage", destination: "Tempe, AZ",  api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
  
      expect(response.status).to eq(400)
      expect(json[:error]).to eq("invalid parameters")
    end
    xit 'returns invalid if different word salad is given', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "ioppheangehe", destination: "Tempe, AZ",  api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(400)
      expect(json[:error]).to eq("invalid parameters")
    end
    xit 'returns invalid if different word salad is given for destinatino', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "Tempe, AZ", destination: "naheapgaeh",  api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(400)
      expect(json[:error]).to eq("invalid parameters")
    end
  end
end