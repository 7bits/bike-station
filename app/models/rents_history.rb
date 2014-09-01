class RentsHistory < ActiveRecord::Base
  self.table_name = 'rents_history'
  self.primary_key = 'day'
  default_scope { order 'day DESC' }

  belongs_to :station

  def rents
    Rent.where('id IN (?)', self.rents_ids)
  end

  # It is PSQL View
  def readonly?
    true
  end
end