class Coordinates 
  attr_reader :lat,
              :lng

  def initialize(data)
    @lat = find_lat(data)
    @lng = find_long(data)
  end

  def find_lat(data)
    if data.lat
      data.lat
    elsif data[:results].first[:locations].empty?
      0
    else  
      data[:results].first[:locations].first[:latLng][:lat]
    end
  end

  def find_long(data)
    if data.lng 
      data.lng
    elsif data[:results].first[:locations].empty?
      0
    else  
      data[:results].first[:locations].first[:latLng][:lng]
    end
  end
end