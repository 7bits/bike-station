class LocationPresenter
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def wrap
    {lat: location.lat, lng: location.lng, bike_id: location.bike_id}
  end

  def self.wrap(locations)
    locations ||= []
    locations.map do |location|
      new(location).wrap
    end
  end
end