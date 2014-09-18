class RentBikesPresenter
  attr_reader :rent
  def initialize(rent)
    @rent = rent
  end

  def wrap
    hash = {
      user: {
        name: rent.user.name,
        surname: rent.user.surname,
      },
      rent: {
        time: TimeDiff.new.diff(rent.opened_at, rent.closed_at),
        cost: CurrencyPresenter.new.wrap(CostCounter.new.calculate_cost(rent))
      },
      bike: {
        id: rent.bike.id,
        name: rent.bike.name,
        name_with_id: "#{rent.bike.id} - #{rent.bike.name}"
      }
    }
  end

  def self.wrap(rents)
    rents.map do |rent|
      new(rent).wrap
    end
  end
end
