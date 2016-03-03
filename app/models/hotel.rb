class Hotel < ActiveRecord::Base
  has_many :reservations
  has_many :users, through: :reservations
  has_attached_file :avatar, styles: { thumb: "300x300>", show: "500x500>" }, :default_url => "default_thumb.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :cost, presence: true
  validates_length_of :phone_number, :within => 10..12
end
