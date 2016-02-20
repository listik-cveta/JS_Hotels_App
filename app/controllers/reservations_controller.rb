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
    @reservation = Reservation.new(reservation_params)
    @reservation.hotel_id = params[:hotel_id]
    @reservation.user_id = current_user.id
    if @reservation.save 
      redirect_to user_reservations_path(current_user)
    else
      redirect_to root_path, alert: "Unable to create reservation"
    end
  end 

  def edit 
  end

  def update
  end 

  def delete
  end 

  private 

  def reservation_params
    params.require(:reservation).permit(:num_nights, :num_guests, :check_in, :hotel_id)
  end

  # def logged_in
  #   unless user_signed_in?
  #     redirect_to new_user_session_path, alert: "Access denied"
  #   end 
  # end

end #ends class
