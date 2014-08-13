class Station < ActiveRecord::Base
  has_many :bikes
  has_many :outgoing_rents, class_name: 'Rent', foreign_key: 'starting_station_id'
  has_many :incoming_rents, class_name: 'Rent', foreign_key: 'terminal_station_id'

  has_many :rents_histories

  def free_gates_count
    gates_count - bikes.unused.count
  end
end
