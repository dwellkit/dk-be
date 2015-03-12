json.(@warranty, :created_at, :updated_at)

json.warranty do
  json.description @warranty.description
  json.warranty_number @warranty.warranty_number
  json.expiration_date @warranty.expiration_date
  json.url @warranty.url
  json.notes @warranty.notes

  json.contacts @warranty.contacts do |contact|
  json.name contact.name
  json.company contact.company
  json.telephone_number contact.telephone_number
  json.email contact.email
  json.url contact.url
  json.notes contact.notes
  json.fax_number contact.fax_number
  json.reachable_id contact.reachable_id
  json.reachable_type contact.reachable_type

end
end



