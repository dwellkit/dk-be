json.(@property, :created_at, :updated_at)

json.property do
  json.lotsize @property.lotsize
  json.total_rooms @property.total_rooms
  json.bedrooms @property.bedrooms
  json.bathrooms @property.bathrooms
  json.actual_rooms @property.actual_rooms_count

  json.address do
    json.street_address @property.address.street_address
    json.city @property.address.city
    json.state @property.address.state
    json.zipcode @property.address.zipcode
  end

  json.rooms @property.rooms do |room|
  json.id room.id
  json.name room.name
  json.sqft room.sqft
  json.dimensions room.dimensions
  json.flooring_type room.flooring_type
  json.paint_color room.paint_color

  json.items room.items do |item|
    json.name item.name
  end
end
end
