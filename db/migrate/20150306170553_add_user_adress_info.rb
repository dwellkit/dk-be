class AddUserAdressInfo < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :zip, :integer
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zpid, :string
  end
end
