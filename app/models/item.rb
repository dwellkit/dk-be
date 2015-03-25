class Item < ActiveRecord::Base
  has_many :contacts, as: :reachable
  has_many :reminders
  has_many :warranties, dependent: :destroy
  has_many :insurances
  has_many :pictures, as: :picturable
  belongs_to :room
  belongs_to :property
end
