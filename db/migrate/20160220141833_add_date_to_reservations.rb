class AddDateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :check_in, :date 
  end
end
