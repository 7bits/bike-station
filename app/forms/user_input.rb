class UserInput < Input
  attribute :name,    String
  attribute :surname, String

  validates_presence_of :name, :surname
end