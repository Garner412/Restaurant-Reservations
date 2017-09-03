class Reservation < ActiveRecord::Base
  belongs_to :customer
  belongs_to :table

  validates_presence_of :customer, :table, :num_of_seats_reserved, :reservation_time

end
