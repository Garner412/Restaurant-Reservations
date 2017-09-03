require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe "creating a customer" do
    it "does not accept customer without name" do
      customer = Customer.new(phone_number: "1234567890")
      expect(customer.valid?).to eq false
    end

    it "accepts customer without phone number" do
      customer = Customer.new(name: "Test")
      expect(customer.valid?).to eq true
    end

    it "accepts customer with name and phone number" do
      customer = Customer.new(name: "Test", phone_number: "1234567890")
      expect(customer.valid?).to eq true
    end
  end

  describe "customer" do
    it "has a name" do
      customer = Customer.create(name: "Test", phone_number: "1234567890")
      expect(customer.name).to eq "Test"
    end

    it "has a phone number" do
      customer = Customer.create(name: "Test", phone_number: "1234567890")
      expect(customer.phone_number).to eq "1234567890"
    end
  end

end
