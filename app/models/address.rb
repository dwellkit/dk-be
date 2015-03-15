class Address < ActiveRecord::Base
  belongs_to :property
  belongs_to :contact
  has_many :users, through: :properties
  # validates_uniqueness_of :street_address, :scope => [:user_id, :zipcode], :case_sensitive => false

  def add_location(location)
    parsed = StreetAddress::US.parse(location[:address])
    
    self.full_address = parsed.to_s
    self.state = parsed.state
    self.city = parsed.city
    self.postal_code = parsed.postal_code
    self.number = parsed.number
    self.postal_code_ext = parsed.postal_code_ext
    self.prefix = parsed.prefix
    self.street = parsed.street
    self.street_type = parsed.street_type
    self.suffix = parsed.suffix
    self.unit = parsed.unit
    self.unit_prefix = parsed.unit_prefix
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
