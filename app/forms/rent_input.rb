class RentInput < Input
  attribute :user,    UserInput
  attribute :bike_id, Integer

  validates_presence_of :bike_id, :user
  validate do |e|
    unless user.nil? || user.valid?
      user.errors.messages.each do |k,v|
        errors.add(k,v)
      end
    end
  end
end