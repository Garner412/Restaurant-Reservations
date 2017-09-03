class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all
  end

  def create
    Customer.new(name: params[:firstname], phone_number: params[:phonenumber]
    redirect_to root_path
  end

end
