class Reservation < ActiveRecord::Base
  belongs_to :table

  validates_presence_of :name, :table, :num_of_seats_reserved, :reservation_date, :hour

end
