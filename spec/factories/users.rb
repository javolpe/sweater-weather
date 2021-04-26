FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    api_key { "1234567890ABCDEFGHIJKLMNOPQ" }
  end
end
