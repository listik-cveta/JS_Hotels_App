class UsersController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  
  def index
    @users = User.all
    unless user_signed_in? && current_user.admin?
      if user_signed_in?
        redirect_to root_path, alert: "Access denied."
      else
        redirect_to new_user_session_path, alert: "Access denied."
      end
    end
  end 

  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.order(sort_column + " " + sort_direction) #need this for sorting 
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