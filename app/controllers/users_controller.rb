class UsersController < ApplicationController
  
  def index
    @users = User.all 
  end 

  def show
    @user = User.find(params[:id])
    unless @user == current_user || @user.try(:admin?)
      redirect_to root_path, alert: "Access denied."
    end
  end 

end 