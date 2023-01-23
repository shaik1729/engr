class RemoveColumnUserIdFromDepartments < ActiveRecord::Migration[6.1]
  def change
    remove_column :departments, :user_id, :integer
  end
end
