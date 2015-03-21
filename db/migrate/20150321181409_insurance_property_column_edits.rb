class InsurancePropertyColumnEdits < ActiveRecord::Migration
  def change
    add_column :properties, :insurance_id, :integer
    add_column :insurances, :property_id, :integer
  end
end
