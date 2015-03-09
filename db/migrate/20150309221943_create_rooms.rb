class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :sqft
      t.string :dimensions
      t.string :flooring_type
      t.string :wall_type
      t.string :paint_color

      t.timestamps null: false
    end
  end
end
