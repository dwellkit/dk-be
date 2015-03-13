class Warranty < ActiveRecord::Base
  belongs_to :item
  belongs_to :property
  has_many :reminders
  has_many :contacts, as: :reachable
  has_many :events
end
