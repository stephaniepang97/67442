class CreateSessionQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :session_questions do |t|
      t.references :patient_sessions, foreign_key: true
      t.references :questions, foreign_key: true

      t.timestamps
    end
  end
end
