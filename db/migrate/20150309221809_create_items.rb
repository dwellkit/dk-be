class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :category
      t.sting :name
      t.datetime :purchase_date
      t.string :serial_number
      t.float :price
      t.string :condition

      t.timestamps null: false
    end
  end
end
