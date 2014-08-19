class BikeRegistrator
  def register!(input)
    bike = Bike.find_or_create_by uuid: input.uuid
    raise BikeNotFound.new if bike.nil?

    station = Station.find_by(id: input.station_id)
    raise StationNotFound.new if station.nil?

    if bike.update_attributes(registration_id: input.registration_id, name: input.name, station: station)
      bike
    else
      raise BikeRegistrationError.new(bike.errors.messages)
    end
  end

  class StationNotFound < StandardError; end
  class BikeNotFound < StandardError; end
  class BikeRegistrationError < StandardError; end
end