require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe "creating a reservation" do
    let(:table) { Table.new(number: 2, num_of_seats: 4) }

    it "successfully creates a reservation" do
      reservation = Reservation.new(name: "test", table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1)
      expect(reservation.valid?).to eq true
    end

    it "Does not accept reservation without a name" do
      reservation = Reservation.new(table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1)
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation without a table" do
      reservation = Reservation.new(name: "Test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1)
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation without the number of seats to reserve" do
      reservation = Reservation.new(name: "Test", table: table, reservation_date: Date.new(2017,9,10), hour: 1)
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation without a date" do
      reservation = Reservation.new(name: "Test", table: table, num_of_seats_reserved: 3, hour: 1)
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation without a time" do
      reservation = Reservation.new(name: "Test", table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10))
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation with negative seats reserved" do
      reservation = Reservation.new(name: "test", table: table, num_of_seats_reserved: -3, reservation_date: Date.new(2017,9,10), hour: 1)
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation with hour less than 0" do
      reservation = Reservation.new(name: "test", table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: -1)
      expect(reservation.valid?).to eq false
    end

    it "Does not accept reservation with hour greater than 23" do
      reservation = Reservation.new(name: "test", table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 25)
      expect(reservation.valid?).to eq false
    end


  end

  describe "reservation" do

    let(:table) { Table.new(number: 2, num_of_seats: 4) }
    let(:reservation) { Reservation.new(name: "Test", table: table, num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1) }

    it "has a name" do
      expect(reservation.name).to eq "Test"
    end

    it "has a table" do
      expect(reservation.table).to eq table
    end

    it "has a number of seats reserved" do
      expect(reservation.num_of_seats_reserved).to eq 3
    end

    it "has a date" do
      expect(reservation.reservation_date).to eq Date.new(2017,9,10)
    end

    it "has an hour" do
      expect(reservation.hour).to eq 1
    end
  end

end
