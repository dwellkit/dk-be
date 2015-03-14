class Property < ActiveRecord::Base
  has_many :rooms
  has_many :groundskeepers
  has_many :users, through: :groundskeepers
  has_many :insurances
  has_many :warranties
  has_one :address
  has_many :items

  # IMAGE ATTACHMENT VALIDATIONS
  has_attached_file :profile, :styles => { :large => "800x800", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :profile, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, :attributes => :profile, :less_than => 2.megabytes
  validates_attachment_file_name :profile, :matches => [/png\Z/, /jpe?g\Z/]


  def create_from_zillow!(location)
    data = Zillow.fetch_robust(location)
    if data
      if data.is_a?(Hash) # THEN ROBUST RESULT
        self.update(data)
      else                # NORMAL RESULTS
        data = Zillow.fetch_normal(data)
        self.update(data)
      end
      create_rooms
      create_items
    else
      return false
    end
  end

  def create_rooms
    self.bedrooms.times do |x|
      self.rooms.create(:name => "Bedroom #{x+1}")
    end
    self.bathrooms.ceil.times do |x|
      self.rooms.create(:name => "Bathroom #{x+1}")
    end
  end

  def create_items

  end
end