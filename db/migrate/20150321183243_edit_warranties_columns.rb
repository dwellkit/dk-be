class EditWarrantiesColumns < ActiveRecord::Migration
  def change
    remove_column :warranties, :warranty_id
  end
end
