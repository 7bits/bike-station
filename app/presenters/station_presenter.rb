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
end