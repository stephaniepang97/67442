class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :attachment
      t.string :label
      t.integer :uploaded_by

      t.timestamps
    end
  end
end
