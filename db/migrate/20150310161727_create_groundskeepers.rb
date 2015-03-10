class CreateGroundskeepers < ActiveRecord::Migration
  def change
    create_table :groundskeepers do |t|

      t.timestamps null: false
    end
  end
end
