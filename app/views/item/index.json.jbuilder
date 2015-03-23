json.times @items.each do |item|
  json.id item.id
  json.name item.name
  json.category item.category
  json.purchase_date item.purchase_date
  json.serial_number item.serial_number
  json.price item.price
  json.condition item.condition
  json.pictures item.pictures.each do |picture|
    json.thumb picture.image.url(:thumb)
    json.medium picture.image.url(:medium)
    json.large picture.image.url(:large)
    json.id picture.id
  end
end