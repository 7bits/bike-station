class RentLocationPresenter
  attr_reader :rent
  def initialize(rent)
    @rent = rent
  end

  def wrap
    opened_at = I18n.l rent.opened_at, format: :short
    hash = {
      user: {
        name: rent.user.name,
        surname: rent.user.surname
      },
      bike: {
        name: rent.bike.name,
        bike_id: rent.bike.id
      },
      rent: {
        opened_at: opened_at
      }
    }
  end

  def self.wrap(rents)
    rents.map do |rent|
      new(rent).wrap
    end
  end
end
