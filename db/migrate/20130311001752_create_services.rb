class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.date :date, null: false
      t.references :place, null: false
      t.string :description, null: false
      t.text :notes
      t.integer :hours, null: false
      t.boolean :sent_survey, default: false
      t.boolean :returned_survey, default: false
      t.boolean :trained, default: false
      t.boolean :willing_to_return, default: false
      t.timestamps
    end

    # Create a self-referencing foreign key
    execute <<-SQL
      ALTER TABLE services
        ADD CONSTRAINT fk_service_place
        FOREIGN KEY (place_id)
        REFERENCES places(id)
        ON DELETE CASCADE
    SQL
  end
end
