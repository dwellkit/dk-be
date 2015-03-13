class AddIdsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :property_id, :integer
    add_column :addresses, :contact_id, :integer
  end
end
