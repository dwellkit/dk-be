class AddWarrantyIdToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :warranty_id, :integer
  end
end
