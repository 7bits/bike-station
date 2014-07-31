class Bike < ActiveRecord::Base
  has_many :rents
  belongs_to :station

  scope :unused, -> { where in_use: false }
end
