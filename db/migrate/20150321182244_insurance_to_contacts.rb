class InsuranceToContacts < ActiveRecord::Migration
  def change
    add_column :insurances, :contact_id, :integer
    add_column :contacts, :insurance_id, :integer
  end
end
