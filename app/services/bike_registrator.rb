class BikeRegistrator
  def register!(input)
    bike = Bike.find_by uuid: input.uuid
    raise BikeNotFound.new if bike.nil?

    if bike.update_attribute(:registration_id, input.registration_id)
      bike
    else
      raise BikeRegistrationError.new(bike.errors.messages)
    end
  end
end