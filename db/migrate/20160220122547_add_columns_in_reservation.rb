class AddColumnsInReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :num_nights, :integer, default: 0
    add_column :reservations, :num_guests, :integer, default: 0
  end
end
