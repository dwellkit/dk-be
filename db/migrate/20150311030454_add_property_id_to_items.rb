class AddPropertyIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :property_id, :integer
  end
end
