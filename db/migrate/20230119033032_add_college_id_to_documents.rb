class AddCollegeIdToDocuments < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :college_id, :string
  end
end
