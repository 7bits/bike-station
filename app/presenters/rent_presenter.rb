class RentPresenter
  attr_reader :rent, :cost, :code

  def initialize(rent, cost, code)
    @rent = rent
    @cost = cost
    @code = code
  end 

  def wrap
    hash = {
      rent: {
        opened_at: rent.opened_at, 
        closed_at: rent.closed_at,
        cost: rent.rate.price,
        total_cost: cost,
        total_cost_pretty: CurrencyPresenter.new.wrap(cost)
      },
      user: {
        id: rent.user.id,
        name: rent.user.name,
        surname: rent.user.surname
      }, 
      code: code
    }

    {data: hash}
  end
end
