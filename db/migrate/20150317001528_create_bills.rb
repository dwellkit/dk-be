class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :property_id
      t.string :name
      t.string :company
      t.text :description
      t.datetime :due_date
      t.integer :amount_due
    end
  end
end
