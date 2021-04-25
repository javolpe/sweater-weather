class BackgroundPhoto
  attr_reader :id,
              :image_url,
              :location,
              :credit 


              # :user_id,
              # :artist,
              # :artist_page,
              # :source

  def initialize(data, location)
    @id = id
    @image_url = data[:results].first[:urls][:regular]
    @location = location
    @credit = credit_data(data)
    # @user_id = data[:results].first[:user][:id]
    # @artist = data[:results].first[:user][:name]
    # @artist_page = data[:results].first[:user][:links][:html]
    # @source = "https://unsplash.com/?utm_source=sweater-weather&utm_medium=referral"
  end

  def credit_data(data)
    {user_id: data[:results].first[:user][:id],
     artist: data[:results].first[:user][:name],
     artist_page: data[:results].first[:user][:links][:html],
     source: "https://unsplash.com/?utm_source=sweater-weather&utm_medium=referral"}
  end
end