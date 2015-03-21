class AddColumnsToBills < ActiveRecord::Migration
  def change
    add_column :bills, :bill_type, :string
    add_column :bills, :yearly_total, :integer
  end
end
