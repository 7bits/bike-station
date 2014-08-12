class Operator < ActiveRecord::Base
  validates :uid, uniqueness: true, presence: true
  validates :name, presence: true
end
