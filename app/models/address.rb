class Address < ActiveRecord::Base
  belongs_to :properties
  belongs_to :contact
end
