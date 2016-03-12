class Reservation < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :user

  has_many :guests

  accepts_nested_attributes_for :guests

end #ends class 
