class BikeRegistrator
  def register!(input)
    bike = Bike.find_or_create_by uuid: input.uuid
    raise BikeNotFound.new if bike.nil?

    # TODO: remove setting station
    if bike.update_attributes(registration_id: input.registration_id, name: input.name, station: Station.first)
      bike
    else
      raise BikeRegistrationError.new(bike.errors.messages)
    end
  end
end