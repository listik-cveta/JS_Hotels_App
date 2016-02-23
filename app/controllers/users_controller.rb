class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @users = User.all
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end 

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])
  #   @user.update(user_params)
  # end

  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.order(sort_column + " " + sort_direction) #need this for sorting 
    unless @user == current_user || current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end 

  private
####### CAN I DELETE user_params?????
  # def user_params
  #   params.require(:user).permit(:name, :admin, :age, :money)
  # end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "check_in"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end



end #ends class  