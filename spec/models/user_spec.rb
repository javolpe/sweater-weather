require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do 
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
  end

  describe 'instance methods' do 
    describe 'set_api_key' do 
      it 'sets a secure api_key for a new user' do 
        user = User.create(email: "whatever@example.com",
                            password: "password",
                            password_confirmation: "password")
        
        expect(user.api_key).to be_a(String)
        expect(user.api_key.length).to eq(26)
      end
    end
  end
end
