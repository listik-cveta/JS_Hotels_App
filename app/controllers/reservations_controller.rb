class ReservationsController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction

  def index
    # @reservations = Reservation.order(sort_column + " " + sort_direction)
    @user = User.find(params[:user_id])
    @reservations = @user.reservations.order(sort_column + " " + sort_direction)

    
    unless current_user == @user || current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end 

  def all_res 
    @reservations = Reservation.order(sort_column + " " + sort_direction)
  end

  def show
    @user = User.find(params[:user_id])
    @reservation = @user.reservations.find(params[:id])
  end

  def new
    @reservation = Reservation.new
    # @reservation.guests.build 
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
    elsif @reservation.check_in < Time.now
      flash.now[:notice] = "Please select a valid date"
      render :new 
    else 
      current_user.money -= (@reservation.num_nights * @hotel.cost) 
      current_user.save 
      flash[:alert] = "Thanks for booking a room at #{@hotel.name}!"
      @reservation.save!
      redirect_to user_reservations_path(current_user)
    end 
  end 

  def edit
    @reservation = Reservation.find(params[:id])
    #@reservation.guests.build #creates empty inputs 
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update(reservation_params)
    @reservation.hotel_id = params[:hotel_id]
    @reservation.user = current_user
    @reservation.save
    redirect_to user_reservation_path(current_user, @reservation)
  end 

  def destroy
    @reservation = Reservation.find(params[:id])
    @hotel = Hotel.find_by_id(@reservation.hotel_id)
    current_user.money += (@reservation.num_nights * @hotel.cost)
    current_user.save
    @reservation.destroy
    flash[:alert] = "Your reservation at #{@hotel.name} has been deleted. You have been refunded $#{@hotel.cost * @reservation.num_nights}"
    if current_user.admin?
      redirect_to all_res_path
    else
      redirect_to user_reservations_path(current_user)
    end
  end 

  private 

  def reservation_params
    params.require(:reservation).permit(:num_nights, :num_guests, :check_in, :hotel_id, guests_attributes: [:id, :name, :_destroy])
  end

  def sort_column
    Reservation.column_names.include?(params[:sort]) ? params[:sort] : "check_in"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end #ends class
