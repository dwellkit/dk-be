class Event < ActiveRecord::Base
belongs_to :warranty
belongs_to :insurance
belongs_to :item
belongs_to :user
belongs_to :property
end
