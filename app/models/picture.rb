class Picture < ActiveRecord::Base
  belongs_to :picturable, polymorphic: true

  has_attached_file :image, :styles => { :large => "800x800", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 2.megabytes
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
end
