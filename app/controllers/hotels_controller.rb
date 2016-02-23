class HotelsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index #view all hotels
    @hotels = Hotel.order(sort_column + " " + sort_direction) 
    unless user_signed_in?
      redirect_to new_user_session_path 
    end
  end 

  def show #view a single hotel 
    @hotel = Hotel.find(params[:id])
    unless user_signed_in?
      redirect_to new_user_session_path 
    end
  end 

  def new
    @hotel = Hotel.new
    unless current_user.admin?
      redirect_to hotels_path, alert: "Access denied."
    end
  end 

  def create 
    @hotel = Hotel.create(hotel_params)
    unless current_user.admin?
      redirect_to hotels_path, alert: "Access denied."
    end
    redirect_to hotel_path(@hotel) 
  end 

  def edit 
    @hotel = Hotel.find(params[:id])
    unless current_user.admin?
      redirect_to hotels_path, alert: "Access denied."
    end
  end 

  def update 
    @hotel = Hotel.find(params[:id])
    unless current_user.admin?
      redirect_to hotels_path, alert: "Access denied."
    end
    @hotel.update(hotel_params)
    redirect_to hotel_path(@hotel)
  end

  private 

  def hotel_params 
    params.require(:hotel).permit(:name, :cost, :min_age, :min_nights, :max_guests, :address, :phone_number)
  end 

  def sort_column
    Hotel.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end #ends class 
