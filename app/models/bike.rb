class Bike < ActiveRecord::Base
  has_many :rents
  belongs_to :station
  has_many :bike_locations
  has_one :locations

  scope :unused, -> { where in_use: false }

  def name_with_id
    "#{id} - #{name}"
  end
end
