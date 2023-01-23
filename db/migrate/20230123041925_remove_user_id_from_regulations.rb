class RemoveUserIdFromRegulations < ActiveRecord::Migration[6.1]
  def change
    remove_column :regulations, :user_id, :integer
  end
end
