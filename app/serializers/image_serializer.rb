class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image_url, :location, :credit
end
