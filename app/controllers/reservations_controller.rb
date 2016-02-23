class ReservationsController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction

  def index
    @reservations = Reservation.order(sort_column + " " + sort_direction)
    
    unless user_signed_in? && current_user.admin?
      if user_signed_in?
        redirect_to root_path, alert: "Access denied."
      else
        redirect_to new_user_session_path, alert: "Access denied."
      end
    end
  end 

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end 

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.hotel_id = params[:hotel_id]
    @reservation.user = current_user
    @hotel = Hotel.find(params[:hotel_id])

    if (@hotel.cost * @reservation.num_nights) > current_user.money 
      flash.now[:notice] = "Sorry, you don't have enough money to stay here"
      render :new  
    elsif @hotel.min_age > current_user.age 
      flash.now[:notice] = "Sorry, you are not old enough to stay here"
      render :new
    elsif @hotel.min_nights > @reservation.num_nights 
      flash.now[:notice] = "Sorry, you need to stay here at least #{@hotel.min_nights} nights" 
      render :new
    elsif @hotel.max_guests < @reservation.num_guests 
      flash.now[:notice] = "Sorry, only a maximum of #{@hotel.max_guests} guests are allowed to stay here"
      render :new
    elsif @reservation.check_in == nil
      flash.now[:notice] = "Please select a valid date"
      render :new 
    else 
      current_user.money -= (@reservation.num_nights * @hotel.cost) 
      current_user.save 
      flash[:alert] = "Thanks for booking a room at #{@hotel.name}!"
      @reservation.save!
      redirect_to user_path(current_user)
    end 
  end 

  def edit
    @reservation = Reservation.find(params[:id])
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
    flash[:alert] = "Your reservation has been deleted. You have been refunded $#{@hotel.cost * @reservation.num_nights}"
    redirect_to user_path(current_user)
  end 

  private 

  def reservation_params
    params.require(:reservation).permit(:num_nights, :num_guests, :check_in, :hotel_id)
  end

  def sort_column
    Reservation.column_names.include?(params[:sort]) ? params[:sort] : "check_in"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end #ends class
