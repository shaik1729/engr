class AddFieldsToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :department_id, :integer
    add_column :documents, :regulation_id, :integer
    add_column :documents, :subject_id, :integer
  end
end
