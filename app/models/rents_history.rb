class RentsHistory < ActiveRecord::Base
  self.table_name = 'rents_history'
  self.primary_key = 'day'
  default_scope { order 'day DESC' }

  def rents
    Rent.where('id IN (?)', self.rents_ids)
  end
end