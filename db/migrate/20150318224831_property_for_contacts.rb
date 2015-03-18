class PropertyForContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :property_id, :integer
  end
end
