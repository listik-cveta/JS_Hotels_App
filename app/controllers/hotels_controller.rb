class HotelsController < ApplicationController

  def index #view all hotels
    @hotels = Hotel.all 
  end 

  def show #view a single hotel 
    @hotel = Hotel.find(params[:id])
  end 

  def new
    @hotel = Hotel.new
  end 

  def create 
    @hotel = Hotel.create(hotel_params)
    redirect_to hotel_path(@hotel) 
  end 

  def edit 
    @hotel = Hotel.find(params[:id])
  end 

  def update 
    @hotel = Hotel.find(params[:id])
    @hotel.update(hotel_params)
    redirect_to hotel_path(@hotel)
  end

  private 

  def hotel_params 
    params.require(:hotel).permit(:name, :cost, :min_age, :min_nights, :max_guests, :address, :phone_number)
  end 


end #ends class 
