class MapStationPresenter
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
      bikes_count: station.bikes.unused.count
    }
  end

  def self.wrap(stations)
    stations.map do |station|
      new(station).wrap
    end
  end
end