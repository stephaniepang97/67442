class AddFieldsToSessionQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :session_questions, :answered_correctly, :boolean
  end
end
