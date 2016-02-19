class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :cost, default: 1
      t.integer :min_age, default: 1
      t.integer :min_nights, default: 1
      t.integer :max_guests, default: 1

      t.timestamps null: false
    end
  end
end
