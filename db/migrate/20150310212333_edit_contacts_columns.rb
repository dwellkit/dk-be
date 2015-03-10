class EditContactsColumns < ActiveRecord::Migration
  def change
    add_column :contacts, :reachable_id, :integer
    add_column :contacts, :reachable_type, :string
    rename_column :contacts, :tax_number, :fax_number
  end
end
