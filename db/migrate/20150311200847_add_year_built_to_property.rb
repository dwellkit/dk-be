class AddYearBuiltToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :yearbuilt, :integer
  end
end
