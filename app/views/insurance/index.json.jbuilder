json.(@insurance, :created_at, :updated_at)

json.insurance do
  json.company @insurance.company
  json.description @insurance.description
  json.policy_number @insurance.policy_number
  json.expiration_date @insurance.expiration_date
  json.url @insurance.url
  json.notes @insurance.notes

  json.contacts @insurance.contacts do |contact|
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
