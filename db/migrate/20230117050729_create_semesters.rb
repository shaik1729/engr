class CreateSemesters < ActiveRecord::Migration[6.1]
  def change
    create_table :semesters do |t|
      t.string :sem

      t.timestamps
    end
  end
end
