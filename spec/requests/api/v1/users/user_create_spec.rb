require 'rails_helper'

RSpec.describe 'API::V1::Users#Create', type: :request do
  describe 'happy path' do 
    it 'creates a user and auto-gens a unique API key if a new email/password is given', :vcr do 

      body = {email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"}
      
      headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      post api_v1_users_path, headers: headers, params: body.to_json
      
      user_1 = User.find_by(email: body[:email])
      
    end
  end
end