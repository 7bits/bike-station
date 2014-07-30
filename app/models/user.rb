class User < ActiveRecord::Base
  has_many :rents
end
