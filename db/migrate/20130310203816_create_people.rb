class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.integer :representative_id
      t.string :email
      t.timestamps
    end

    # Create a self-referencing foreign key
    execute <<-SQL
      ALTER TABLE people
        ADD CONSTRAINT fk_people_representatives
        FOREIGN KEY (representative_id)
        REFERENCES people(id)
        ON DELETE SET NULL
    SQL
  end
end
