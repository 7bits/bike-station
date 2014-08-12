class Rent < ActiveRecord::Base
  belongs_to :bike
  belongs_to :user
  belongs_to :starting_station, class_name: 'Station', foreign_key: 'starting_station_id'
  belongs_to :terminal_station, class_name: 'Station', foreign_key: 'terminal_station_id'

  default_scope { order 'openned_at' }
  scope :openned, -> { where closed_at: nil }
  scope :closed, -> { where.not closed_at: nil }
  scope :for_station, ->(station_id) {
    where('starting_station_id = :station_id OR terminal_station_id = :station_id', station_id: station_id )
  }
end
