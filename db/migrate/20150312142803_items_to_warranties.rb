class ItemsToWarranties < ActiveRecord::Migration
  def change
    add_column :warranties, :item_id, :integer
  end
end
