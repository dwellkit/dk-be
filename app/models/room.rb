class Room < ActiveRecord::Base
  belongs_to :property #, counter_cach: :count_of_actual_rooms
  has_many :items
end
