class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all.order('reservation_date, hour, name')
  end

  def create

    reserved_tables = Table.joins(:reservations).merge(Reservation.where(reservation_date: reservation_params[:reservation_date], hour: reservation_params[:hour]))
    all_tables = Table.all.order(:num_of_seats)
    available_tables = all_tables - reserved_tables
    total_capacity_available = 0

    available_tables.each do |table|
      total_capacity_available += table.num_of_seats
    end

    if total_capacity_available < reservation_params[:num_of_seats_reserved].to_i
      flash[:alert] = "Reservation Failed: Seating Capacity Exceeded"
    else
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
      flash[:notice] = "Reservation has successfully been created"
    end

    redirect_to root_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:name, :num_of_seats_reserved, :reservation_date, :hour)
  end

end
