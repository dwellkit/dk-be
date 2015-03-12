class Address < ActiveRecord::Base
  belongs_to :property
  belongs_to :contact
end
