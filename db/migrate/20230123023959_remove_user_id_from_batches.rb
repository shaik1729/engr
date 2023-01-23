class RemoveUserIdFromBatches < ActiveRecord::Migration[6.1]
  def change
    remove_column :batches, :user_id, :integer
  end
end
