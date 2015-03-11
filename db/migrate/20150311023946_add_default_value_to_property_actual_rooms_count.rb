class AddDefaultValueToPropertyActualRoomsCount < ActiveRecord::Migration
  def change
    change_column :properties, :actual_rooms_count, :integer, default: 0
  end
end
