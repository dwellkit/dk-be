class AddPropertoyIdToWarranties < ActiveRecord::Migration
  def change
    add_column :warranties, :property_id, :integer
  end
end
