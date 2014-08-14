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
        openned_at: rent.openned_at, 
        closed_at: rent.closed_at,
        cost: rent.rate.price,
        total_cost: cost
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
