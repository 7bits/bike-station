class Operator < ActiveRecord::Base
  validates :uid, uniqueness: true, presence: true
  validates :name, presence: true
  validates :token, uniqueness: true

  def approve
    update_attribute :approved, true
  end

  def un_approve
    update_attribute :approved, false
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
