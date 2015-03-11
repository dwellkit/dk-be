class Contact < ActiveRecord::Base
  belongs_to :reachable, polymorphic: true
  has_one :address
end
