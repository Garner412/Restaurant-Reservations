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

  describe "self.makes_reservation" do
    
    it "successfully makes reservation" do
      reservation = {name: "Test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1}
      table = []
      table << Table.create!(number: 2, num_of_seats: 4)
      expect { Reservation.make_reservation(table, reservation) }.to change {Reservation.all.count}.by(1)
    end
  end

  describe "self.book_table" do

    it "successfully books table" do
      reservation = {name: "Test", num_of_seats_reserved: 3, reservation_date: Date.new(2017,9,10), hour: 1}
      table = Table.new(number: 2, num_of_seats: 4)
      expect { Reservation.book_table(reservation, table) }.to change {Reservation.all.count}.by(1)
    end
  end

  describe "self.need_more_seats" do

    it "successfully evaluates when more seats available" do
      table = Table.new(number: 2, num_of_seats: 4)
      seats_needed = 3
      expect(Reservation.need_more_seats(table, seats_needed)).to eq false
    end

    it "successfully evaluates when more seats are needed" do
      table = Table.new(number: 2, num_of_seats: 4)
      seats_needed = 5
      expect(Reservation.need_more_seats(table, seats_needed)).to eq true
    end
  end

end
