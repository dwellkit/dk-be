class AddCountColumnProperties < ActiveRecord::Migration
  def change
    add_column :properties, :actual_rooms_count, :integer
  end
end
