class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.datetime :start_date
      t.string :name
      t.string :description
      t.string :frequency
      t.timestamps null: false
    end
  end
end
