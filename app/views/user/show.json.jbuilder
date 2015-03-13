json.(@user, :created_at, :updated_at)

  json.user @user.email
  json.property do
    json.property @user.properties
  end

