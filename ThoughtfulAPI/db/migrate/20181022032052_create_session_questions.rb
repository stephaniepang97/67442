class CreateSessionQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :session_questions do |t|
      t.integer :patient_session_id
      t.integer :question_id
      t.boolean :correct

      t.timestamps
    end
  end
end
