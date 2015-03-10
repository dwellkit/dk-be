class RemoveUserIdFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :user_id
  end
end
