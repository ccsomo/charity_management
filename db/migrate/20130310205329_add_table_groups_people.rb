class AddTableGroupsPeople < ActiveRecord::Migration
  def change
    create_table :groups_people, id: false do |t|
      t.references :group, null: false
      t.references :person, null: false
    end

    # Create a foreign key for person_id
    execute <<-SQL
      ALTER TABLE groups_people
        ADD CONSTRAINT fk_groups_people_person_id
        FOREIGN KEY (person_id)
        REFERENCES people(id)
        ON DELETE CASCADE
    SQL

    # Create a foreign key for skill_id
    execute <<-SQL
      ALTER TABLE groups_people
        ADD CONSTRAINT fk_groups_people_group_id
        FOREIGN KEY (group_id)
        REFERENCES groups(id)
        ON DELETE CASCADE
    SQL

    add_index :groups_people, [:person_id, :group_id], unique: true
    add_index :groups_people, [:group_id, :person_id], unique: true

  end
end
