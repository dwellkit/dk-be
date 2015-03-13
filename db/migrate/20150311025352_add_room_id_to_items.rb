class AddRoomIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :room_id, :integer
  end
end
