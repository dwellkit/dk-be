class ColumnNameEditProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :rooms
  end
end
