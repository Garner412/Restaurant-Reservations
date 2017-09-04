class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all
  end

  def create
    # I couldn't get the where.not to return the tables that were not reserved at the time so I queried the reserved tables and subtracted them from all tables to find the available.

    reserved_tables = Table.joins(:reservations).merge(Reservation.where(reservation_date: reservation_params[:reservation_date], hour: reservation_params[:hour]))

    all_tables = Table.all

    available_tables = all_tables - reserved_tables

    available_tables.each do |table|
      if table.num_of_seats >= reservation_params[:num_of_seats_reserved].to_i
        @reservation = Reservation.new(name: reservation_params[:name], table: table, num_of_seats_reserved: reservation_params[:num_of_seats_reserved], reservation_date: reservation_params[:reservation_date], hour: reservation_params[:hour])
        @reservation.save
        break
      end
    end

    redirect_to root_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:name, :num_of_seats_reserved, :reservation_date, :hour)
  end

end
