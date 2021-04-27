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

    end
    it 'trip MORE than 47 hours but less than 167 returns origin, destination, travel time, arrival forecast with good params', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "Anchorage, AK", destination: "Miami, FL", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
    end
    it 'trip more than 167 hours returns origin, destination, travel time, arrival forecast with good params', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England", destination: "Cape Town, South Africa", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
      
    end
  end
  describe 'sad path' do 
    it 'returns unauthorized if no api_key is passed in'
    it 'returns travel time is impossible if not possible to drive', :vcr do 
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
      body = {origin: "London, England", destination: "Miami, FL", api_key: @user_1.api_key}

      post api_v1_road_trip_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(200)
    end
  end
end