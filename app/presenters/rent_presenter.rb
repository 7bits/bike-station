class RentPresenter
  attr_reader :rent, :code

  def initialize(rent, code)
    @rent = rent
    @code = code
  end 

  def wrap
    hash = {openned_at: rent.openned_at, user: rent.user.attributes, code: code, cost: 10}
    hash[:total_cost] = 100 if code == :close
    {data: hash}
  end
end
