class BikeInput < Input
  attribute :uuid, String
  attribute :registration_id, String
  attribute :name, String
  attribute :bike_id, Number

  validates_presence_of :uuid, :registration_id, :name, :bike_id
end