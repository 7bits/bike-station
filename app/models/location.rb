class Location < ActiveRecord::Base
  self.table_name = 'locations'
  self.primary_key = 'bike_id'
  default_scope { order 'bike_id DESC' }

  belongs_to :bike

  # It is PSQL View
  def readonly?
    true
  end
end