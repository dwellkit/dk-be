class AddColumnsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :name, :string
    add_column :pictures, :is_primary, :boolean, default: :false
    add_column :pictures, :picturable_id, :integer
    add_column :pictures, :picturable_type, :string
    change_column :addresses, :addressable_type, :string
  end
end
