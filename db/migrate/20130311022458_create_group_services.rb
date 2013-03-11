class CreateGroupServices < ActiveRecord::Migration
  def change
    create_table :group_services do |t|
      t.references :group, null: false
      t.references :service, null: false
      t.integer :members_served, null: false
      t.timestamps
    end

    # Create a foreign key for group_id
    execute <<-SQL
      ALTER TABLE group_services
        ADD CONSTRAINT fk_group_services_group_id
        FOREIGN KEY (group_id)
        REFERENCES groups(id)
        ON DELETE CASCADE
    SQL

    # Create a foreign key for service_id
    execute <<-SQL
      ALTER TABLE group_services
        ADD CONSTRAINT fk_group_services_service_id
        FOREIGN KEY (service_id)
        REFERENCES services(id)
        ON DELETE CASCADE
    SQL

    add_index :group_services, [:group_id, :service_id], unique: true
    add_index :group_services, [:service_id, :group_id], unique: true

  end
end
