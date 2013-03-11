class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.date :date, null: false
      t.string :type
      t.references :group
      t.references :person
      t.references :service
      t.decimal :amount
      t.decimal :dollar_value
      t.string :description
      t.timestamps
    end

    # Create a foreign key for person_id
    execute <<-SQL
      ALTER TABLE donations
        ADD CONSTRAINT fk_donations_person
        FOREIGN KEY (person_id)
        REFERENCES people(id)
        ON DELETE CASCADE
    SQL

    # Create a foreign key for group_id
    execute <<-SQL
      ALTER TABLE donations
        ADD CONSTRAINT fk_donations_group
        FOREIGN KEY (group_id)
        REFERENCES groups(id)
        ON DELETE CASCADE
    SQL

    # Create a foreign key for service_id
    execute <<-SQL
      ALTER TABLE donations
        ADD CONSTRAINT fk_donations_service
        FOREIGN KEY (service_id)
        REFERENCES services(id)
        ON DELETE CASCADE
    SQL

    # Create a trigger to require proper data for cash donation
    # This trigger throws a "random" error when the proper information is not supplied:
    # It is not permitted to delete within an insert statement, but there is no other way
    # to cancel a transaction within a saved function in SQL. The Model validations for Donations
    # will further prevent and explain these transaction failures.
    execute <<-SQL
      create trigger valid_donation
        after insert on donations
        for each row begin
          if new.type = 'CashDonation' and (new.person_id is null and new.group_id is null) or new.amount is null then
            delete from donations where id = new.id;
          elseif new.type = 'InKindDonation' and (new.service_id is null or new.description is null or new.amount is null) then
            delete from donations where id = new.id;
          elseif new.type not in ('CashDonation', 'InKindDonation') then
            delete from donations where id = new.id;
          end if;
      end;
    SQL
  end
end
