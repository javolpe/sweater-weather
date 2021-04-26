require 'rails_helper'

RSpec.describe 'API::V1::Users#Create', type: :request do
  describe 'happy path' do 
    it 'creates a user and auto-gens a unique API key if a new email/password is given', :vcr do 

      body = {email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_users_path, headers: headers, params: body.to_json
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data].keys.count).to eq(3)
      expect(json[:data][:id]).to be_a(String)
      expect(json[:data][:type]).to eq("users")
      expect(json[:data][:attributes].keys.count).to eq(2)
      expect(json[:data][:attributes][:email]).to be_a(String)
      expect(json[:data][:attributes][:api_key]).to be_a(String)
    end
  end
  describe 'sad path' do 
    it 'raises the right exception if missing a field', :vcr do 
      body = {email: "whatever@example.com",
        password_confirmation: "password"}
        
        headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
        
        post api_v1_users_path, headers: headers, params: body.to_json

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:error]).to eq("Validation failed: Password can't be blank")
      end
      it 'raises the proper exception if user email is already taken', :vcr do 
        User.create({email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"})

          body = {email: "whatever@example.com",
            password: "password",
            password_confirmation: "password"}
          
          headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    
          post api_v1_users_path, headers: headers, params: body.to_json
          
          json = JSON.parse(response.body, symbolize_names: true)
          
          expect(json[:error]).to eq("Validation failed: Email has already been taken")
      end
      it 'raises the proper exception if password and password_confirm dont match', :vcr do 
          body = {email: "whatever@example.com",
            password: "password",
            password_confirmation: "password123"}
          
          headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    
          post api_v1_users_path, headers: headers, params: body.to_json
          
          json = JSON.parse(response.body, symbolize_names: true)
          
          expect(json[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
      end
    end
  end
  