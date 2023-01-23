class RemoveSemesterIdFromSubjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :subjects, :semester_id, :integer
  end
end
