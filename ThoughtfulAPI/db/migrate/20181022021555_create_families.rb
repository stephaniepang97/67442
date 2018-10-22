class CreateFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :families do |t|
      t.string :family_name
      t.integer :patient_id

      t.timestamps
    end
  end
end
