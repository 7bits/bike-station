class RentService
  def open_rent(user, bike)
    rent = Rent.new(user: user, bike: bike, openned_at: DateTime.now)
    rent if rent.save
  end

  def close_rent(bike)
    rent = Rent.where('closed_at is NULL').find_by(bike: bike)
    rent.update_attribute(:closed_at, DateTime.now) if rent
    rent
  end
end