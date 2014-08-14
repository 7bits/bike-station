class RentService
  def open_rent(input, station)
    rent = Rent.new
    
    ActiveRecord::Base.transaction do 
      bike = station.bikes.where(in_use: false).find(input.bike_id)
      user = User.create!(input.user.attributes)
      rate = RateFactory.build
      rent = Rent.create!(user: user, bike: bike, openned_at: DateTime.now, starting_station: station, rate: rate)
      bike.update_attributes!(in_use: true)
    end

    rent
  end

  def close_rent(rent_id, station)
    rent = Rent.where('closed_at is NULL').find(rent_id)
    
    ActiveRecord::Base.transaction do
      rent.update_attributes!(closed_at: DateTime.now, terminal_station: station)
      rent.bike.update_attributes!(in_use: false, station: station)
    end

    rent
  end
end