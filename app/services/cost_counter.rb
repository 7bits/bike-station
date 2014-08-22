class CostCounter
  def calculate_cost(rent)
    (rent.rate.price * rent.duration).ceil
  end

  # TODO: make calculations on sql server
  def calculate_daily_cost(station)
    station.outgoing_rents.closed.today.map do |rent|
      calculate_cost(rent)
    end.inject(&:+) || 0
  end

  def calculate_total_cost(station)
    station.incoming_rents.closed.map do |rent|
      calculate_cost(rent)
    end.inject(&:+) || 0
  end
end
