class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :company
      t.string :telephone_number
      t.string :email
      t.string :url
      t.text :notes
      t.string :tax_number

      t.timestamps null: false
    end
  end
end
