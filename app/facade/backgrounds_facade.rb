class BackgroundsFacade 
  def self.background_index(location)
    @image_info = UnsplashService.find_city_photo(location)
    @photo = BackgroundPhoto.new(@image_info, location)
    @serial = ImageSerializer.new(@photo)
  end
end