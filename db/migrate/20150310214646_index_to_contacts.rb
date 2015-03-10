class IndexToContacts < ActiveRecord::Migration
  def change
    add_index :contacts, :reachable_id
  end
end
