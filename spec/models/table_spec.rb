require 'rails_helper'

RSpec.describe Table, type: :model do

  describe "creating a table" do
    it "does not accept table without a number" do
      table = Table.new(num_of_seats: 6)
      expect(table.valid?).to eq false
    end

    it "accepts table without phone number" do
      table = Table.new(number: 1)
      expect(table.valid?).to eq true
    end

    it "accepts table with number and number of seats" do
      table = Table.new(number: 1, num_of_seats: 4)
      expect(table.valid?).to eq true
    end
  end

  describe "table" do
    it "has a number" do
      table = Table.create(number: 1, num_of_seats: 4)
      expect(table.number).to eq 1
    end

    it "has a number of seats" do
      table = Table.create(number: 1, num_of_seats: 4)
      expect(table.num_of_seats).to eq 4

    end
  end

end
