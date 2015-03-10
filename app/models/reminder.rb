class Reminder < ActiveRecord::Base
  belongs_to :item
  belongs_to :property
  belongs_to :insurance
  belongs_to :warranty
end
