class FixAddressesTables < ActiveRecord::Migration
  def change
    add_column :addresses, :number, :string
    add_column :addresses, :postal_code, :string
    add_column :addresses, :prefix, :string
    add_column :addresses, :street, :string
    add_column :addresses, :street_type, :string
    add_column :addresses, :suffix, :string
    add_column :addresses, :unit, :string
    add_column :addresses, :unit_prefix, :string

    add_column :addresses, :full_address, :string

    remove_column :addresses, :zpid
    remove_column :addresses, :zipcode
    remove_column :addresses, :street_address
  end
end