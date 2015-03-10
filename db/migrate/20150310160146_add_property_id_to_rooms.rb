class AddPropertyIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :property_id, :integer
  end
end
