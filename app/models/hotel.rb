class Hotel < ActiveRecord::Base
  has_many :reservations
  has_many :users, through: :reservations

  validates :name, presence: true
  validates :cost, presence: true
  validates_length_of :phone_number, :within => 10..12
end
