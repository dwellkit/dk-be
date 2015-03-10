class Reminder < ActiveRecord::Base
  has_many :items
  belongs_to :property
  belongs_to :insurance
  belongs_to :warranty
end
