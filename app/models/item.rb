class Item < ActiveRecord::Base
  has_many :contacts, as: :reachable
  has_many :reminders
  has_many :warranties
  has_many :insurances
  belongs_to :room
  belongs_to :property
end
