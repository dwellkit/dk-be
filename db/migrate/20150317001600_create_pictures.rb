class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.integer :user_id
      t.boolean :is_primary, default: :false
      t.integer :picturable_id
      t.string :picturable_type
    end
  end
end
