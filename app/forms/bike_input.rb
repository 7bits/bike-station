class BikeInput < Input
  attribute :uuid, String
  attribute :registration_id, String

  validates_presence_of :uuid, :registration_id
end