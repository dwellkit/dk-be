class ItemsToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :item_id, :integer
  end
end
