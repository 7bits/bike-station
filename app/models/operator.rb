class Operator < ActiveRecord::Base
  validates :email, uniqueness: true
end
