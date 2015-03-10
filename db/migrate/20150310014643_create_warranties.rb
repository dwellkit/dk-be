class CreateWarranties < ActiveRecord::Migration
  def change
    create_table :warranties do |t|
      t.string :name
      t.text :description
      t.string :warranty_number
      t.datetime :expiration_date
      t.string :url
      t.text :notes
      t.timestamps null: false
    end
  end
end
