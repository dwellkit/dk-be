class Warranty < ActiveRecord::Base
  belongs_to :item
  belongs_to :property
  has_many :reminders
  has_many :contacts
end
