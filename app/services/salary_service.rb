class SalaryService
  
  def self.conn 
    connection = Farady.new(url: "https://developers.teleport.org")
  end

  def self.find_city(search)
    response = conn.get('/api/cities/') do |f|
      f.params['search'] = search
      f.params['limit'] = 1
    end
    parse(response)['_embedded']['city:search-results'][0]['_links']['city:item']['href']
  end 

  def self.find_city_info(search)
    response = Faraday.get(find_city(search))
    parse(response)
  end

  def parse(response) 
    JSON.parse(response.body, symbolize_names: true)
  end
end