class AddFieldsToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :department_id, :string
    add_column :documents, :regulation_id, :string
    add_column :documents, :subject_id, :string
  end
end
