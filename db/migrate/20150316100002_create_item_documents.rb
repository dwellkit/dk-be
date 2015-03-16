class CreateItemDocuments < ActiveRecord::Migration
  def change
    create_table :item_documents do |t|

      t.timestamps null: false
    end
  end
end
