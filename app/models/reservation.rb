class Reservation < ActiveRecord::Base
  attr_accessor :users_attributes
  belongs_to :hotel
  belongs_to :user

  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, allow_destroy: true

end #ends class 
