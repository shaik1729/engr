class AddFieldsToDepartment < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :college_id, :integer
  end
end
