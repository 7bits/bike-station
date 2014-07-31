class Station < ActiveRecord::Base
  has_many :bikes
  has_many :outgoing_rents, class_name: 'Rent'
  has_many :incoming_rents, class_name: 'Rent'
end
