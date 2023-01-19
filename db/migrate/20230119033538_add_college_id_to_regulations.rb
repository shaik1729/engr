class AddCollegeIdToRegulations < ActiveRecord::Migration[6.1]
  def change
    add_column :regulations, :college_id, :string
  end
end
