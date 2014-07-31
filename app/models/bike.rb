class Bike < ActiveRecord::Base
  has_many :rents

  scope :unused, -> { where in_use: false }
end
