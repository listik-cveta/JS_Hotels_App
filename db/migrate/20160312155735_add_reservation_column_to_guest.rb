class AddReservationColumnToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :reservation_id, :integer
  end
end
