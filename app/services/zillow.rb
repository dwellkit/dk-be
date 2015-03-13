class Zillow
  # class HouseNotFound < StandardError

  def self.find_by_location(prop)
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
    else
      response["searchresults"]["response"]["results"]["result"]["zpid"]
    end
  end

  ##################
  # ROBUST RESULTS #
  ##################

  def self.get_robust_property_info(zpid)
    zwsid = 'X1-ZWz1ayawttov7v_6o78e'
    prop_domain = "http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?"
    response = HTTParty.get("#{prop_domain}zws-id=#{zwsid}&zpid=#{zpid}")
    if !response["updatedPropertyDetails"]["message"]["text"].include?("Error")
      return response
    else
      return false
    end
  end

  def self.fetch_robust(property)
    zpid = Zillow.find_by_location(property)
    data = Zillow.get_robust_property_info(zpid)
    Zillow.build_robust_property(zpid, data)
  end

  def self.build_robust_property(zpid, data)
    if data
      result = {zpid: zpid, sqft: data["updatedPropertyDetails"]["response"]["editedFacts"]["finishedSqFt"].to_i || 0,
                lotsize: data["updatedPropertyDetails"]["response"]["editedFacts"]["lotSizeSqFt"].to_i || 0,
                bedrooms: data["updatedPropertyDetails"]["response"]["editedFacts"]["bedrooms"].to_i || 0,
                bathrooms: data["updatedPropertyDetails"]["response"]["editedFacts"]["bathrooms"].to_f || 0,
                yearbuilt: data["updatedPropertyDetails"]["response"]["editedFacts"]["yearBuilt"].to_i || 0}
    else
      return zpid
    end
  end

  ###################
  # NORMAL RESULTS #
  ###################

  def self.fetch_normal(zpid)
    data = Zillow.get_normal_property_info(zpid)
    Zillow.build_normal_property(zpid, data)
  end

  def self.build_normal_property(zpid, data)
    if data
      result = {zpid: zpid, sqft: data["comps"]["response"]["properties"]["principal"]["finishedSqFt"].to_i || 0,
                lotsize: data["comps"]["response"]["properties"]["principal"]["lotSizeSqFt"].to_i || 0,
                bedrooms: data["comps"]["response"]["properties"]["principal"]["bedrooms"].to_i || 0,
                bathrooms: data["comps"]["response"]["properties"]["principal"]["bathrooms"].to_f || 0,
                yearbuilt: data["comps"]["response"]["properties"]["principal"]["yearBuilt"].to_i || 0}
    else
      return false
    end
  end

  def self.get_normal_property_info(zpid)
    zwsid = 'X1-ZWz1ayawttov7v_6o78e'
    comp_domain = "http://www.zillow.com/webservice/GetDeepComps.htm?"
    response = HTTParty.get("#{comp_domain}zws-id=#{zwsid}&zpid=#{zpid}&count=1")
    if !response["comps"]["message"]["text"].include?("Error")
      return response
    end
  end
end
## OTHER OPTIONS FROM ROBUST
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