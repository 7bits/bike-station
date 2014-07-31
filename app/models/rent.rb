class Rent < ActiveRecord::Base
  belongs_to :bike
  belongs_to :user

  default_scope { order 'openned_at' }
  scope :openned, -> { where 'closed_at is NULL' }
end
