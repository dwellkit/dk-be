json.(@warranty, :created_at, :updated_at)

json.warranty do
  json.description @warranty.description
  json.warranty_number @warranty.warraty_number
  json.expiration_date @warranty.expiration_date
  json.url @warranty.url
  json.notes @warranty.notes

  json.conacts do
    json.name @warranty.contacts.name
    json.company @warranty.contacts.company
    json.telephone_number @warranty.contacts.telephone_number
    json.email @warranty.contacts.email
    json.url @warranty.contacts.url
    json.notes @warranty.contacts.notes
    json.fax_number @warranty.contacts.fax_number
    json.reachable_id @warranty.contacts.reachable_id
    json.reachable_type @warranty.contacts.reachable_type
  end

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



