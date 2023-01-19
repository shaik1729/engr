class AddSemesterIdToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :semester_id, :string
  end
end
