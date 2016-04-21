class HotelSerializer < ActiveModel::Serializer
  attributes :name, :cost, :phone_number, :address, :min_age, :min_nights, :max_guests
  has_many :reservations
end
