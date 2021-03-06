class Room < ActiveRecord::Base
  belongs_to :property, counter_cache: :actual_rooms_count
  has_many :pictures, as: :picturable
  has_many :items
end
