class AddCollegeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :college_id, :integer
  end
end
