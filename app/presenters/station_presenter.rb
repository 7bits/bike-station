class StationPresenter
  attr_reader :station

  def initialize(station)
    @station = station
  end

  def wrap
    {
        id: station.id,
        lat: station.latitude,
        lng: station.longitude,
        name: station.name,
    }
  end

  def self.wrap(stations)
    stations.map do |station|
      new(station).wrap
    end
  end

  def wrap_table
    {
      id: station.id,
      name: station.name,
      unused_bikes_count: station.bikes.unused.count,
      total_cost: CurrencyPresenter.new.wrap(CostCounter.new.calculate_total_cost(station)),
    }
  end

  def self.wrap_table(stations)
    stations.map do |station|
      new(station).wrap_table
    end
  end
end