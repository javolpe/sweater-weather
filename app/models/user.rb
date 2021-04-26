class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, on: :create, presence: true
  validates_presence_of :password, require: true

  before_create :set_api_key

  def set_api_key
    self.api_key = generate_api_key
  end

  def generate_api_key 
    SecureRandom.hex(13)
  end
end
