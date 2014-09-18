class ClosedRentFlash
  def initialize(rent_presenter)
    @p = rent_presenter[:data]
  end

  def flash
    "#{@p[:user][:name]} #{@p[:user][:surname]} - #{@p[:rent][:total_cost_pretty]}"
  end
end