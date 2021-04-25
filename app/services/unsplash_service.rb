class UnsplashService
  def self.conn 
    connection = Faraday.new(url: "https://api.unsplash.com") do |req|
      req.params['client_id'] = ENV['UNSPLASH_KEY']
    end
  end

  def self.find_city_photo(location)
    response = conn.get("/search/photos") do |req|
      req.params['query'] = "#{location},skyline"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end