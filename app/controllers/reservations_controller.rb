class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all 
  end 

  def show
  end 

  def new
    @reservation = Reservation.new
  end 

  def create
  end 

  def edit 
  end

  def update
  end 

  def delete
  end 

  private 

  def reservation_params
    params.require(:reservation).permit(:num_nights, :num_guests)
  end

end
