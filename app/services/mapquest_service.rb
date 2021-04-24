class MapquestService 
  def self.conn 
    connection = Faraday.new(url: "http://www.mapquestapi.com") do |req|
      req.params['key'] = ENV['MAP_KEY']
    end
  end 

  def self.find_lat_long(city)
    response = conn.get("/geocoding/v1/address") do |req|
      req.params['location'] = city
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end