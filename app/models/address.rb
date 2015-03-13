class Address < ActiveRecord::Base
  belongs_to :property
  belongs_to :contact
  has_many :users, through: :properties
end
