class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :reg_no, :string
    add_column :users, :mobile_number, :string
    add_column :users, :batch_id, :integer
    add_column :users, :department_id, :integer
    add_column :users, :regulation_id, :integer
  end
end
