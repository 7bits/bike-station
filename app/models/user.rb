class User < ActiveRecord::Base
  has_many :rents

  validates :name, presence: true
  validates :surname, presence: true
  mount_uploader :photo, PhotoUploader
end
