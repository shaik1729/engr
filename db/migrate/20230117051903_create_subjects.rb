class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :code
      t.integer :regulation_id
      t.integer :semester_id
      t.integer :college_id

      t.timestamps
    end
  end
end
