class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :item_id
      t.integer :warranty_id
      t.integer :insurance_id
      t.string :name
      t.text :notes
    end
  end
end
