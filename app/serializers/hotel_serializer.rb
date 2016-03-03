class HotelSerializer < ActiveModel::Serializer
  attributes :id. :name, :cost, :phone, :address, :min_age, :min_nights, :max_guests
end
