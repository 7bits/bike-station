class UserInput < Input
  attribute :name,    String
  attribute :surname, String
  attribute :photo

  validates_presence_of :name, :surname, :photo
end