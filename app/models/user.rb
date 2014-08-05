class User < ActiveRecord::Base
  has_many :rents

  validates :name, presence: true
  validates :surname, presence: true
end
