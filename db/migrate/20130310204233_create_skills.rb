class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :description, null: false
      t.timestamps
    end

    add_index :skills, :description, unique: true
  end
end
