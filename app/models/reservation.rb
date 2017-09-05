class Reservation < ActiveRecord::Base
  belongs_to :table

  validates_presence_of :name, :table, :num_of_seats_reserved, :reservation_date, :hour

  validates_inclusion_of :hour, in: 0..23

  validates :num_of_seats_reserved, numericality: { greater_than_or_equal_to: 0 }

  def self.make_reservation(available_tables, reservation_params)
    seats_needed = reservation_params[:num_of_seats_reserved].to_i
    while seats_needed > 0
      if available_tables[-1].num_of_seats <= seats_needed
        @reservation = Reservation.new(name: reservation_params[:name], table: available_tables[-1], num_of_seats_reserved: reservation_params[:num_of_seats_reserved], reservation_date: reservation_params[:reservation_date], hour: reservation_params[:hour])
        @reservation.save
      else
        available_tables.each do |table|
          if table.num_of_seats >= seats_needed
            @reservation = Reservation.new(name: reservation_params[:name], table: table, num_of_seats_reserved: reservation_params[:num_of_seats_reserved], reservation_date: reservation_params[:reservation_date], hour: reservation_params[:hour])
            @reservation.save
            break
          end
        end
      end
      seats_needed -= available_tables[-1].num_of_seats
      available_tables.pop
    end
  end

end
