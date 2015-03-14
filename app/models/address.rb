class Address < ActiveRecord::Base
  belongs_to :property
  belongs_to :contact
  has_many :users, through: :properties
  validates_uniqueness_of :street_address, :scope => [:user_id, :zipcode], :case_sensitive => false

  def add_location(location)
    street = location[:street_address].gsub('+', ' ')
    street = street.split.map(&:capitalize).join(' ')
    city = location[:city].split.map(&:capitalize).join(' ')
    state = location[:state].upcase

    self.street_address = street
    self.zipcode = location[:zipcode]
    self.city = city
    self.state = state
    self.property_id = self.id
  end
end
