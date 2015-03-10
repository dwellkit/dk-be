class RemoveColumnsFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :street_address
    remove_column :properties, :city
    remove_column :properties, :zipcode
    remove_column :properties, :state
  end
end
