class Operator < ActiveRecord::Base
  validates :uid, uniqueness: true, presence: true
  validates :name, presence: true

  def approve
    update_attribute :approved, true
  end

  def un_approve
    update_attribute :approved, false
  end
end
