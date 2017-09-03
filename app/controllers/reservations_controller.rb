class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all
  end

  def create
    # Check for table availibility
      #check time - see if any available
        #grab tables that are available
      #check size
        #
    # If table available, create reservation
    redirect_to root_path
  end

end
