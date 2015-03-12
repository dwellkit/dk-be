class EditTablesAndColumns < ActiveRecord::Migration
  def change
    add_column :items, :warranty_id, :integer
    add_column :items, :insurance_id, :integer
    add_column :rooms, :user_entered, :boolean, default: true
    change_column :properties, :bathrooms, :float
  end
end
