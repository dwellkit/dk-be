json.(@user, :created_at, :updated_at)

  json.user @user.email
  json.property @properties do |property|
  json.image do
    json.thumb property.profile.url(:thumb)
  end
    json.id property.id
    json.sqft property.sqft
    json.lotsize property.lotsize
    json.total_rooms property.total_rooms
    json.bedrooms property.bedrooms
    json.bathrooms property.bathrooms
    json.actual_rooms property.actual_rooms_count
    json.yearbuilt property.yearbuilt
  
      json.address property.address
  end

