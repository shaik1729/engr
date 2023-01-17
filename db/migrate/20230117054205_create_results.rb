class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :internal_marks
      t.string :external_marks
      t.string :total_marks
      t.string :result
      t.string :credits
      t.string :grade
      t.string :subject_id
      t.string :regulation_id
      t.string :batch_id
      t.string :semester_id
      t.string :user_id
      t.string :college_id

      t.timestamps
    end
  end
end
