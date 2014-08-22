class RentLocationPresenter
  attr_reader :rent
  def initialize(rent)
    @rent = rent
  end

  def wrap
    openned_at = I18n.l rent.openned_at, format: :short
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
        openned_at: openned_at
      }
    }
  end

  def self.wrap(rents)
    rents.map do |rent|
      new(rent).wrap
    end
  end
end
