class AddAddressIdToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :address_id, :integer
  end
end
