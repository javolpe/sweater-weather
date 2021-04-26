class SalaryService 

  def self.conn 
    connection = Faraday.new(url: "https://api.teleport.org")
  end

  def self.find_city(search)
    response = conn.get('/api/cities/') do |f|
      f.params['search'] = search
    end
    data = parse(response)
    data[:"_embedded"][:"city:search-results"].first[:_links][:"city:item"][:href]
  end 

  def self.find_city_with_id(search)
    endpoint = find_city(search)
    response = Faraday.get(endpoint)
    data = parse(response)
    data[:_links][:"city:urban_area"][:href]
  end

  def self.find_urban_area_salaries(search)
    endpoint = find_city_with_id(search)
    response = Faraday.get("#{endpoint}salaries/")
    data = parse(response)
    data[:salaries]
  end

  def self.parse(response) 
    JSON.parse(response.body, symbolize_names: true)
  end
end