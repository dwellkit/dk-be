class CreateInsuranceDocuments < ActiveRecord::Migration
  def change
    create_table :insurance_documents do |t|

      t.timestamps null: false
    end
  end
end
