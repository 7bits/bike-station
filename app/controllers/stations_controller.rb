class StationsController < ApplicationController
  def index
    @stations = Station.all
  end

  def history
    station = Station.find_by(id: params[:station_id])
    rents = Rent.where("starting_station_id = :station_id OR terminal_station_id = :station_id",
      {station_id: station.id}).where.not(closed_at: nil)
    presenter = RentBikesPresenter.wrap(rents)
    @rents = presenter
  end
end
