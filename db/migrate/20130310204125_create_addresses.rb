class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :person, null: false
      t.string :street
      t.string :city
      t.column :state, "char(2)"
      t.string :zip, limit: 11
      t.timestamps
    end

    add_index :addresses, :person_id, unique: true

    execute <<-SQL
      ALTER TABLE addresses
        ADD CONSTRAINT fk_addresses_person_id
        FOREIGN KEY (person_id)
        REFERENCES people(id)
        ON DELETE CASCADE
    SQL
  end
end
