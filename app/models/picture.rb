class Picture < ActiveRecord::Base
  belongs_to :picturable, polymorphic: true
end
