class ChangeColumnPictures < ActiveRecord::Migration
  def change
    rename_column :pictures, :user_id, :property_id
    add_column :pictures, :item_id, :integer
    add_column :pictures, :room_id, :integer
    add_column :warranties, :warranty_id, :integer
  end
end
