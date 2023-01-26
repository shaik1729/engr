class AddCollegeIdToBatches < ActiveRecord::Migration[6.1]
  def change
    add_column :batches, :college_id, :integer
  end
end
