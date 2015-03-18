json.(@contact, :created_at, :updated_at)

json.contact do
  json.property_id @contact.property_id
  json.id @contact.id
  json.name @contact.name
  json.company @contact.company
  json.telephone_number @contact.telephone_number
  json.email @contact.email
  json.url @contact.url
  json.fax_number @contact.fax_number
  json.notes @contact.notes
  json.reachable_id @contact.reachable_id
  json.reachable_type @contact.reachable_type

end
