class AddColumnsToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :company, :string
    add_column :insurances, :description, :text
    add_column :insurances, :policy_number, :integer
    add_column :insurances, :expiration_date, :datetime
    add_column :insurances, :url, :string
    add_column :insurances, :notes, :text
  end
end
