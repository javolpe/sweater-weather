require 'rails_helper' 

RSpec.describe 'API:V1::Users#Login', type: :request do 
  before :each do 
    user_1 = User.create({email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"})
  end
  describe 'happy path' do 
    it 'logs a user in if they exist in the Users table', :vcr do
      body = {email: "whatever@example.com", password: "password"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_sessions_path, headers: headers, params: body.to_json
      expect(response.status).to eq(200)

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
    it 'returns an error message if email is incorrect', :vcr do 
      body = {email: "whatever1@example.com", password: "password"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_sessions_path, headers: headers, params: body.to_json
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("bad credentials")
    end
    it 'returns an error message if password is incorrect', :vcr do 
      body = {email: "whatever@example.com", password: "password1"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_sessions_path, headers: headers, params: body.to_json
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("bad credentials")
    end
    it 'returns an error message if no email is provided', :vcr do 
      body = { password: "password1"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_sessions_path, headers: headers, params: body.to_json
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("bad credentials")
    end
    it 'returns an error message if no password is provided', :vcr do 
      body = { email: "whatever@example.com"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_sessions_path, headers: headers, params: body.to_json
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("bad credentials")
    end
    it 'returns an error message if header isnt specified to json', :vcr do 
      body = {email: "whatever@example.com", password: "password"}
    
      post api_v1_sessions_path, headers: headers, params: body.to_json
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("bad credentials")
    end
  end
end