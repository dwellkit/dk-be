class Property < ActiveRecord::Base
  has_many :rooms
  has_many :groundskeepers
  has_many :users, through: :groundskeepers
  has_many :insurances
  has_many :warranties
  belongs_to :address, as: :addressable
end
