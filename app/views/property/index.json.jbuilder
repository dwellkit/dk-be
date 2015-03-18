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

  json.rooms @property.rooms do |room|
    json.id room.id
    json.name room.name
    json.sqft room.sqft
    json.dimensions room.dimensions
    json.flooring_type room.flooring_type
    json.paint_color room.paint_color

    json.items room.items do |item|
      json.id item.id
      json.name item.name
    end
  end
  json.items @property.items do |item|
    json.name item.name
    json.category item.category
    item.serial_number
  end
end
