class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :user_id
      
      t.integer :rooms
      t.integer :sqft
      t.integer :lotsize
      
      t.integer :total_rooms
      t.integer :bedrooms
      t.integer :bathrooms
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :zpid
      
      t.timestamps null: false
    end
  end
end
