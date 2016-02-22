class HotelsController < ApplicationController

  def index #view all hotels
    @hotels = Hotel.all 
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


end #ends class 
