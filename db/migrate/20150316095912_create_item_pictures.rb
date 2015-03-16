class CreateItemPictures < ActiveRecord::Migration
  def change
    create_table :item_pictures do |t|

      t.timestamps null: false
    end
  end
end
