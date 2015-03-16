class CreatePropertyPictures < ActiveRecord::Migration
  def change
    create_table :property_pictures do |t|

      t.timestamps null: false
    end
  end
end
