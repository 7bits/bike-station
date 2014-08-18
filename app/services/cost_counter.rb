class CostCounter
  def calculate_cost(rent)
    (rent.rate.price * rent.duration).round
  end

  # TODO: make calculations on sql server
  def calculate_total_cost(station)
    station.incoming_rents.map do |rent|
      calculate_cost(rent)
    end.inject(&:+) || 0
  end
end
