class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
  
    if user.admin?
      can :manage, :all
    elsif !user.nil?
      can :create, Reservation, :user_id => user.id
      can :update, Reservation, :user_id => user.id
      can :destroy, Reservation, :user_id => user.id 
      can :read, Reservation, :user_id => user.id 
      can :read, Hotel

      can :manage, User do |u|
        u.id == user.id 
      end

      # can :create, User, :user => user
      # can :update, User, :user => user
      # can :delete, User, :user => user 
      #can :read, User, :id => user.id
      #can :delete, User, :id => user.id 
      #can :update, User, :id => user.id
      
    end #end if/else
  end #end def
end #end class
