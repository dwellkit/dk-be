json.(@property, :created_at, :updated_at)

json.property do
  json.image do
    json.thumb @property.profile.url(:thumb)
    json.medium @property.profile.url(:medium)
    json.large @property.profile.url(:large)
  end
  json.id @property.id
  json.lotsize @property.lotsize
  json.sqft @property.sqft
  json.yearbuilt @property.yearbuilt
  json.total_rooms @property.total_rooms
  json.bedrooms @property.bedrooms
  json.bathrooms @property.bathrooms
  json.actual_rooms @property.actual_rooms_count

  json.address do
    json.street_address @property.address.full_address
  end

  json.pictures @property.pictures.each do |picture|
    json.thumb picture.image.url(:thumb)
    json.medium picture.image.url(:medium)
    json.large picture.image.url(:large)
  end

  json.rooms @property.rooms do |room|
    json.id room.id
    json.name room.name
    json.sqft room.sqft
    json.dimensions room.dimensions
    json.flooring_type room.flooring_type
    json.paint_color room.paint_color

    json.pictures room.pictures.each do |picture|
      json.id picture.id
      json.thumb picture.image.url(:thumb)
      json.medium picture.image.url(:medium)
      json.large picture.image.url(:large)
    end

    json.items room.items do |item|
      json.id item.id
      json.name item.name
      json.price item.price
    end
  end
  json.items @property.items do |item|
    json.id item.id
    json.name item.name
    json.category item.category
    json.serial_number item.serial_number
    json.price item.price
  end
end
