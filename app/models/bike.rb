class Bike < ActiveRecord::Base
  has_many :rents
  belongs_to :station
  has_many :bike_locations
  has_one :locations

  scope :unused, -> { where in_use: false }
end
