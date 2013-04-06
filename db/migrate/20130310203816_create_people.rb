class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
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

    # Create a trigger to validate a person's name OR email is present
    execute <<-SQL
      create trigger valid_person
        after insert on people
        for each row begin
          if (new.name is null and new.email is null) then
            SIGNAL sqlstate '45004' set message_text = "Cannot set a person without name or email";
          end if;
        end;
    SQL
  end
end
