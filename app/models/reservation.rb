class Reservation < ActiveRecord::Base
  belongs_to :hotel_id
  belongs_to :user_id
end
