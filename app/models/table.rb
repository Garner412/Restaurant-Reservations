class Table < ActiveRecord::Base
  has_many :reservations

  validates_presence_of :number, :num_of_seats

end
