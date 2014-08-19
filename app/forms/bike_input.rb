class BikeInput < Input
  attribute :uuid, String
  attribute :registration_id, String
  attribute :name, String
  attribute :station_id, Integer

  validates_presence_of :uuid, :registration_id, :name, :station_id
end