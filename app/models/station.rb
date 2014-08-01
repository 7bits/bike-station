class Station < ActiveRecord::Base
  has_many :bikes
  has_many :outgoing_rents, class_name: 'Rent'
  has_many :incoming_rents, class_name: 'Rent'

  def free_gates_count
    gates_count - bikes.unused.count
  end
end
