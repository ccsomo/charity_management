class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :city, null: false
      t.timestamps
    end
  end
end
