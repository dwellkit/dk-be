class EditBillsTable < ActiveRecord::Migration
  def change
    remove_column :bills, :yearly_total
    add_column :bills, :month, :string
  end
end
