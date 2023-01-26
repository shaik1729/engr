class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :short_form
      t.string :code
      t.integer :user_id

      t.timestamps
    end
  end
end
