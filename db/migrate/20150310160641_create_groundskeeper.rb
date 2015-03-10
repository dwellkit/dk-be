class CreateGroundskeeper < ActiveRecord::Migration
  def change
    create_table :groundskeepers, id: false do |t|
      t.integer :user_id
      t.integer :property_id
    end
    add_index :groundskeepers, :user_id
    add_index :groundskeepers, :property_id
  end
end
