class AddUsersToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :user_id, :integer
    add_column :users, :address_id, :integer
  end
end
