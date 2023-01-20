class AddFieldsToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :college_id, :integer
    add_column :notifications, :batch_id, :integer
    add_column :notifications, :department_id, :integer
    add_column :notifications, :regulation_id, :integer
    add_column :notifications, :by_admin, :boolean, default: false
  end
end
