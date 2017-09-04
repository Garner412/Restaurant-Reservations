class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name, null: false
      t.references :table, index: true, foreign_key: true, null: false
      t.integer :num_of_seats_reserved
      t.date :reservation_date, null: false
      t.integer :hour, null: false

      t.timestamps null: false
    end
  end
end
