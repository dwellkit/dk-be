class Item < ActiveRecord::Base
  has_many :contacts
  has_many :reminders
  has_many :warranties
  belongs_to :user
  belongs_to :room
  belongs_to :property
end
