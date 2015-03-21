
json.images @pictures.each do |picture|
  json.id picture.id
  json.thumb picture.image.url(:thumb)
  json.medium picture.image.url(:medium)
  json.large picture.image.url(:large)
end
