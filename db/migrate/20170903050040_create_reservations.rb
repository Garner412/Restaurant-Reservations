class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :customer, index: true, foreign_key: true, null: false
      t.references :table, index: true, foreign_key: true, null: false
      t.integer :num_of_seats_reserved
      t.datetime :reservation_time, null: false

      t.timestamps null: false
    end
  end
end
