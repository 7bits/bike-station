class RentsHistoryPresenter
  attr_reader :history

  def initialize(history)
    @history = history
  end

  def wrap
    {
        day: DayPresenter.new.wrap(history.day),
        rents: RentBikesPresenter.wrap(history.rents)
    }
  end

  def self.wrap(histories)
    histories.map do |history|
      new(history).wrap
    end
  end
end