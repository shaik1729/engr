class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :code
      t.string :regulation_id
      t.string :semester_id
      t.string :college_id

      t.timestamps
    end
  end
end
