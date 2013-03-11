class AddTablePeopleSkills < ActiveRecord::Migration
  def change
    create_table :people_skills, id: false do |t|
      t.references :person, null: false
      t.references :skill, null: false
    end

    # Create a foreign key for person_id
    execute <<-SQL
      ALTER TABLE people_skills
        ADD CONSTRAINT fk_people_skills_person_id
        FOREIGN KEY (person_id)
        REFERENCES people(id)
        ON DELETE CASCADE
    SQL

    # Create a foreign key for skill_id
    execute <<-SQL
      ALTER TABLE people_skills
        ADD CONSTRAINT fk_people_skills_skill_id
        FOREIGN KEY (skill_id)
        REFERENCES skills(id)
        ON DELETE CASCADE
    SQL

    add_index :people_skills, [:person_id, :skill_id], unique: true
    add_index :people_skills, [:skill_id, :person_id], unique: true
  end
end
