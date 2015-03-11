class Property < ActiveRecord::Base
  has_many :rooms
  has_many :groundskeepers
  has_many :users, through: :groundskeepers
  has_many :insurances
  has_many :warranties
  has_one :address
  has_many :items


  def add( property_location )
    search_zillow(property_location)
  end

  def search_zillow(prop)
    search_domain = 'http://www.zillow.com/webservice/GetSearchResults.htm'
    zwsid = 'X1-ZWz1ayawttov7v_6o78e'
    address = prop[:street_address]
    city = prop[:city]
    state = prop[:state]
    zip = prop[:zipcode]
    citystatezip = city + " " + state + " " + zip
    citystatezip = URI::encode(citystatezip)
    address.gsub!(' ','+')

    response = HTTParty.get("#{search_domain}?zws-id=#{zwsid}&address=#{address}&citystatezip=#{citystatezip}")

    if response["searchresults"]["message"]["text"].include?("Error")
      return false
    end
    zpid = response["searchresults"]["response"]["results"]["result"]["zpid"]
    self.zpid = zpid
    # comp_domain = "http://www.zillow.com/webservice/GetDeepComps.htm?"
    prop_domain = "http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?"
    propinfo = HTTParty.get("#{prop_domain}zws-id=#{zwsid}&zpid=#{zpid}")


    if !propinfo["updatedPropertyDetails"]["message"]["text"].include?("Error")

      #pull data => propinfo["updatedPropertyDetails"]["response"]["editedFacts"]
      self.sqft = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["finishedSqFt"].to_i
      self.lotsize = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["lotSizeSqFt"].to_i
      self.bedrooms = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["bedrooms"].to_i
      self.bathrooms = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["bathrooms"].to_f
      # self.yearbuilt = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["yearBuilt"].to_i
      #self.latitude = propinfo["updatedPropertyDetails"]["response"]["address"]["latitude"].to_f
      #self.longitude = propinfo["updatedPropertyDetails"]["response"]["address"]["longitude"].to_f
      #self.view = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["view"]
      #self.home_type = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["useCode"]
      #self.number_of_floors = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["numFloors"]
      #self.basement = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["basement"]
      #self.totalrooms = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["totalRooms"].to_i
      #self.roof_type = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["roof"]
      #self.exterior = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["exteriorMaterial"]
      #self.view = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["view"]
      #self.parking_type = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["parkingType"]
      #self.heating_sources = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["heatingSources"]
      #self.heating_system = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["heatingSystem"]
      #self.cooling_system = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["coolingSystem"]
      #self.appliances = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["appliances"]
      #self.floor_covering = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["floor_covering"]
      #self.rooms = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["rooms"]
      # ADD COOLING SYSTEM AS ITEM IF EXISTS
      if propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["coolingSystem"]
        item = self.items.new
        item.category = "Heating/Cooling Systems"
        item.name = "Cooling - " + propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["coolingSystem"]
        item.save
      end
      if propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["heatingSystem"]
        item = self.items.new
        item.category = "Heating/Cooling Systems"
        item.name = "Heating - " + propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["heatingSystem"]
        item.save
      end
      if propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["appliances"]
        appliances = propinfo["updatedPropertyDetails"]["response"]["editedFacts"]["appliances"].split(', ')
        appliances.each do |appliance|
          item = self.items.new
          item.category = "Appliances"
          item.name = appliance
          item.save
        end
      end

      self.zpid = zpid
      self.save
    else
      comp_domain = "http://www.zillow.com/webservice/GetDeepComps.htm?"
      propinfo = HTTParty.get("#{comp_domain}zws-id=#{zwsid}&zpid=#{zpid}&count=1")

      if !propinfo["comps"]["message"]["text"].include?("Error")
        self.sqft = propinfo["comps"]["response"]["properties"]["principal"]["finishedSqFt"].to_i
        self.bedrooms = propinfo["comps"]["response"]["properties"]["principal"]["bedrooms"].to_i
        self.bathrooms = propinfo["comps"]["response"]["properties"]["principal"]["bathrooms"].to_f
        self.yearbuilt = propinfo["comps"]["response"]["properties"]["principal"]["yearBuilt"].to_i
        self.lotsize = propinfo["comps"]["response"]["properties"]["principal"]["lotSizeSqFt"].to_i
      else
        return false
      end


    end
  self.save
  end
end

# t.integer  "user_id"
# t.integer  "rooms"
# t.integer  "sqft"
# t.integer  "lotsize"
# t.integer  "total_rooms"
# t.integer  "bedrooms"
# t.integer  "bathrooms"
# t.string   "street_address"
# t.string   "city"
# t.string   "state"
# t.string   "zipcode"
# t.string   "zpid"
# t.datetime "created_at",     null: false
# t.datetime "updated_at",
