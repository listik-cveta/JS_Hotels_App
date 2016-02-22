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
    @hotel = Hotel.find(params[:hotel_id])

    if @hotel.cost > current_user.money 
      "Sorry, you don't have enough money to stay here"
      redirect_to user_path(current_user)
    elsif @hotel.min_age > current_user.age 
      "Sorry, you are not old enough to stay here"
      redirect_to user_path(current_user)
    elsif @hotel.min_nights > @reservation.num_nights # Do I need to have a has_many reservations through user?
      "Sorry, you need to stay here at least #{@hotel.min_nights} night(s)" # Can I use pluralize helper?
      redirect_to user_path(current_user)
    elsif @hotel.max_guests < @reservation.num_guests
      "Sorry, only a maximum of #{@hotel.max_guests} guests are allowed to stay here"
      redirect_to user_path(current_user)
    else 
      current_user.money -= (@reservation.num_nights * @hotel.cost) 
      current_user.save 
      "Thanks for booking a room at #{@hotel.name}!"
      @reservation.save!
      redirect_to user_path(current_user)
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
    @hotel = Hotel.find_by_id(@reservation.hotel_id)
    current_user.money += (@reservation.num_nights * @hotel.cost)
    current_user.save
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
