class Property < ActiveRecord::Base
  has_many :rooms
  has_many :groundskeepers
  has_many :users, through: :groundskeepers
  has_many :insurances
  has_many :warranties
  has_one :address
  has_many :items


  def create_from_zillow!(location)
    create_address(location)
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

  def create_address(location)
    #clean up user input
    street = location[:street_address].gsub('+', ' ')
    street = street.split.map(&:capitalize).join(' ')
    city = location[:city].split.map(&:capitalize).join(' ')
    state = location[:state].upcase

    self.save
    a = Address.new
    a.street_address = street.downcase
    a.zipcode = location[:zipcode]
    a.city = city.downcase
    a.state = state.downcase
    a.property_id = self.id
    a.save
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