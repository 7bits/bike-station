class BikeRegistrator
  def register!(input)
    bike = Bike.find_or_create_by uuid: input.uuid
    raise BikeNotFound.new if bike.nil?

    if bike.update_attributes(registration_id: input.registration_id, name: input.name)
      bike
    else
      raise BikeRegistrationError.new(bike.errors.messages)
    end
  end
end