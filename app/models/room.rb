class Room < ActiveRecord::Base
  belongs_to :property
  has_many :items
end
