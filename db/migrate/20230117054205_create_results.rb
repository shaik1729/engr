class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :internal_marks
      t.string :external_marks
      t.string :total_marks
      t.string :result
      t.string :credits
      t.string :grade
      t.integer :subject_id
      t.integer :regulation_id
      t.integer :batch_id
      t.integer :semester_id
      t.integer :user_id
      t.integer :college_id

      t.timestamps
    end
  end
end
