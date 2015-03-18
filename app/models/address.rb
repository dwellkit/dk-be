class Address < ActiveRecord::Base
  belongs_to :property
  belongs_to :contact
  has_many :users, through: :properties
  validates :postal_code, :presence => true
  # validates_uniqueness_of :street_address, :scope => [:user_id, :zipcode], :case_sensitive => false

  def add_location(location)
    parsed = StreetAddress::US.parse(location[:address])
    self.full_address = parsed.to_s || 0
    self.state = parsed.state || 0
    self.city = parsed.city || 0
    self.postal_code = parsed.postal_code || 0
    self.number = parsed.number || 0
    self.postal_code_ext = parsed.postal_code_ext || 0
    self.prefix = parsed.prefix || 0
    self.street = parsed.street || 0
    self.street_type = parsed.street_type || 0
    self.suffix = parsed.suffix || 0
    self.unit = parsed.unit || 0
    self.unit_prefix = parsed.unit_prefix || 0
    # street = location[:street_address].gsub('+', ' ')
    # street = street.split.map(&:capitalize).join(' ')
    # city = location[:city].split.map(&:capitalize).join(' ')
    # state = location[:state].upcase

    # self.street_address = street
    # self.zipcode = location[:zipcode]
    # self.city = city
    # self.state = state
    # self.property_id = self.id
  end
end
