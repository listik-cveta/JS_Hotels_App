class AddContactInfoToHotels < ActiveRecord::Migration
  def change
    add_column :hotels, :address, :string
    add_column :hotels, :phone_number, :string
  end
end
