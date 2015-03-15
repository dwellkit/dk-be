class AddPostalCodeExtToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :postal_code_ext, :string
  end
end
