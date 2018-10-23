class CreateSessionQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :session_questions do |t|
      t.references :patient_session, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
