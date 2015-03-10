class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :zpid
      t.integer :addressable_id
      t.integer :addressable_type
    end

    add_index :addresses, :addressable_id
  end
end
