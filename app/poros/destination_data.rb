class DestinationData 
  attr_reader :travel_time,
              :lat,
              :lng
        
  def initialize(data)
    @travel_time = data[:route][:formattedTime]
    @lat = data[:route][:boundingBox][:lr][:lat]
    @lng = data[:route][:boundingBox][:lr][:lng]
  end
end