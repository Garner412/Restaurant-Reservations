class Reservation < ActiveRecord::Base
  belongs_to :table

  validates_presence_of :name, :table, :num_of_seats_reserved, :reservation_date, :hour

  validates_inclusion_of :hour, in: 0..23

  validates :num_of_seats_reserved, numericality: { greater_than_or_equal_to: 0 }

end
