class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.all
    
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end 

  def show
    @reservation = Reservation.find(params[:id])
   # reservation_permission(@reservation)
  end

  def new
    #logged_in
    @reservation = Reservation.new
  end 

  def create
    #logged_in
    @reservation = Reservation.new(reservation_params)
    @reservation.hotel_id = params[:hotel_id]
    @reservation.user = current_user
    if @reservation.save!
      redirect_to user_path(current_user)
    else
      redirect_to root_path, alert: "Unable to create reservation"
    end
  end 

  def edit
    @reservation = Reservation.find(params[:id])
    #reservation_permission(@reservation)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    @reservation.hotel_id = params[:hotel_id]
    @reservation.user = current_user
    @reservation.save
    redirect_to reservation_path(@reservation)
  end 

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to user_path(current_user), notice: "Your reservation has been deleted"
  end 

  private 

  def reservation_params
    params.require(:reservation).permit(:num_nights, :num_guests, :check_in)
  end

  def reservation_permission(reservation)
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Access denied"
    end

    unless current_user.admin? || reservation.user.id == current_user.id
      redirect_to new_user_session_path, alert: "Access denied"
    end 
  end

  def logged_in
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Access denied"
    end 
  end

end #ends class
