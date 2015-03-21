class PicturesToTables < ActiveRecord::Migration
  def change
    add_column :items, :picture_id, :integer
    add_column :rooms, :picture_id, :integer
    add_column :properties, :picture_id, :integer
  end
end
