class Rent < ActiveRecord::Base
  belongs_to :bike
  belongs_to :user
  belongs_to :rate
  belongs_to :starting_station, class_name: 'Station', foreign_key: 'starting_station_id'
  belongs_to :terminal_station, class_name: 'Station', foreign_key: 'terminal_station_id'

  default_scope { order 'closed_at DESC' }
  scope :opened, -> { where closed_at: nil }
  scope :closed, -> { where.not closed_at: nil }
  scope :for_station, ->(station_id) {
    where('starting_station_id = :station_id OR terminal_station_id = :station_id', station_id: station_id )
  }
  scope :today, -> {where "DATE_TRUNC('day', (closed_at::timestamptz - INTERVAL '0 hour'))::date = ?", Date.today}

  def duration
    (closed_at - opened_at) / 60  # minutes
  end
end
