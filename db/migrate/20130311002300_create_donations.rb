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
          # if new.type = 'CashDonation' and (new.person_id is null and new.group_id is null) or new.amount is null then
          #   delete from donations where id = new.id;
          #   # SIGNAL sqlstate '45001' set message_text = "Cannot set a cash donation without owner and amount!";
          # elseif new.type = 'InKindDonation' and (new.service_id is null or new.description is null or new.amount is null) then
          #   delete from donations where id = new.id;
          #   # SIGNAL sqlstate '45002' set message_text = "Cannot set in-kind donation without service, description, and value!";
          # elseif new.type not in ('CashDonation', 'InKindDonation') then
          #   delete from donations where id = new.id;
          #   # SIGNAL sqlstate '45003' set message_text = "Invalid Donation type!";
          # end if;
          case new.type
          when 'CashDonation' then
            if (new.person_id is null and new.group_id is null) or new.amount is null then
              SIGNAL sqlstate '45001' set message_text = "Cannot set a cash donation without owner and amount!";
            end if;
          when 'InKindDonation' then
            if (new.service_id is null or new.description is null or new.dollar_value is null) then
              SIGNAL sqlstate '45002' set message_text = "Cannot set in-kind donation without service, description, and value!";
            end if;
          else
            SIGNAL sqlstate '45003' set message_text = "Invalid Donation type!";
          end case;
      end;
    SQL
  end
end
