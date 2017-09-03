require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "customer" do
    it "has a name" do
      customer = Customer.create(name: "Greg", phone_number: "1234567890")
    end
  end

end
