class AddTablePeopleServices < ActiveRecord::Migration
  def change
    create_table :people_services, id: false do |t|
      t.references :person, null: false
      t.references :service, null: false
    end

    # Create a foreign key for person_id
    execute <<-SQL
      ALTER TABLE people_services
        ADD CONSTRAINT fk_people_services_person_id
        FOREIGN KEY (person_id)
        REFERENCES people(id)
        ON DELETE CASCADE
    SQL

    # Create a foreign key for service_id
    execute <<-SQL
      ALTER TABLE people_services
        ADD CONSTRAINT fk_people_services_service_id
        FOREIGN KEY (service_id)
        REFERENCES services(id)
        ON DELETE CASCADE
    SQL

    add_index :people_services, [:service_id, :person_id], unique: true
    add_index :people_services, [:person_id, :service_id], unique: true


  end
end
