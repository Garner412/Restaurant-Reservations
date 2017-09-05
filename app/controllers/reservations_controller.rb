class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all.order('reservation_date, hour, name')
  end

  def create
    # I know this adds an additional query to find the available tables, but for some reason I could not get where.not to work for this query.
    reserved_tables = Table.joins(:reservations).merge(Reservation.where(reservation_date: reservation_params[:reservation_date], hour: reservation_params[:hour]))
    all_tables = Table.all.order(:num_of_seats)
    available_tables = all_tables - reserved_tables

    total_capacity_available = available_tables.inject(0) { |sum, tables| sum + tables[:num_of_seats] }

    if total_capacity_available < reservation_params[:num_of_seats_reserved].to_i
      flash[:alert] = "Reservation Failed: Seating Capacity Exceeded"
    else
      Reservation.make_reservation(available_tables, reservation_params)
      flash[:notice] = "Reservation has successfully been created"
    end
    redirect_to root_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:name, :num_of_seats_reserved, :reservation_date, :hour)
  end

end
