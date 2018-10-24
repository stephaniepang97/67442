class CreatePatientSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_sessions do |t|
      t.integer :patient_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
