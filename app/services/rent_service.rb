class RentService
  def open_rent(input)
    bike = Bike.where(in_use: false).find(input.bike_id)
    rent = Rent.new
    ActiveRecord::Base.transaction do 
      user = User.create!(input.user.attributes)
      rent = Rent.create!(user: user, bike: bike, openned_at: DateTime.now)
      bike.update_attributes!(in_use: true)
    end

    rent
  end

  def close_rent(rent_id)
    rent = Rent.where('closed_at is NULL').find(rent_id)
    ActiveRecord::Base.transaction do
      rent.update_attributes!(closed_at: DateTime.now)
      rent.bike.update_attributes!(in_use: false)
    end

    rent
  end
end