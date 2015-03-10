class Insurance < ActiveRecord::Base
  has_many :items
  has_many :contacts, as: :reachable
  has_many :reminders
  belongs_to :property
end
