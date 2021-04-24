require 'rails_helper' 

RSpec.describe 'API::V1::Forecast', type: :request do 
  describe 'happy path' do 
    it 'returns current, hourly, daily weather if given a proper city and state', :vcr do 
      get api_v1_forecast_path, params: {location: "denver,co"}
     
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data]).to be_a(Hash)
      expect(json[:data][:id]).to be_nil 
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes].keys.count).to be(3)

      expect(json[:data][:attributes]).to have_key(:current_weather)
      expect(json[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(json[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(json[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(json[:data][:attributes][:current_weather][:sunset]).to be_a(String)
      expect(json[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(json[:data][:attributes][:current_weather][:humidity]).to be_a(Float).or(be_an Integer)
      expect(json[:data][:attributes][:current_weather][:uvi]).to be_a(Float).or(be_an Integer)
      expect(json[:data][:attributes][:current_weather][:visibility]).to be_a(Float).or(be_an Integer)
      expect(json[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(json[:data][:attributes][:current_weather][:icon]).to be_a(String)

      expect(json[:data][:attributes]).to have_key(:daily_weather)
      expect(json[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(json[:data][:attributes][:daily_weather].count).to eq(5)
      expect(json[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
      expect(json[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
      expect(json[:data][:attributes][:daily_weather].first[:conditions]).to be_a(String)
      expect(json[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)

      expect(json[:data][:attributes]).to have_key(:hourly_weather)
      expect(json[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(json[:data][:attributes][:hourly_weather].count).to eq(8)
      expect(json[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
      expect(json[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:hourly_weather].first[:conditions]).to be_a(String)
      expect(json[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
    end
  end
  describe 'sad path' do
    
  end
end