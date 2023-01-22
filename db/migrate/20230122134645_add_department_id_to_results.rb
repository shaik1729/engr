class AddDepartmentIdToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :department_id, :integer
  end
end
