class CreateSessionQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :session_questions do |t|
      t.references :patient_session_id, foreign_key: true
      t.references :question_id, foreign_key: true

      t.timestamps
    end
  end
end
