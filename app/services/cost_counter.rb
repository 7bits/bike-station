class CostCounter
  def calculate_cost(price, unit)
    cost = price * unit
    cost.to_s
  end

  def calculate_time(openned_at, closed_at)
    time = (closed_at - openned_at) / 60
  end
end
