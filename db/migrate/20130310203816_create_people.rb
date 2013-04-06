class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.integer :representative_id
      t.string :email
      t.string :street
      t.string :city
      t.column :state, "char(2)"
      t.string :zip, limit: 11
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
