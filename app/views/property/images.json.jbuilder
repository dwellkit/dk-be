
json.images @pictures.each do |picture|
    json.thumb picture.image.url(:thumb)
    json.medium picture.image.url(:medium)
    json.large picture.image.url(:large)
    json.id picture.id
  end
