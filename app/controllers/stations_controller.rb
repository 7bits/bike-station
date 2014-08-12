class StationsController < ApplicationController
  def index
    @stations = Station.all

    @breadcrumbs = [Breadcrumb.new('Stations', stations_path, 'active')]
  end

  def show
    @station = Station.find params[:id]

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'active')
    ]
  end

  def history
    @station = Station.find_by(id: params[:station_id])
    rents = Rent.where("starting_station_id = :station_id OR terminal_station_id = :station_id",
      {station_id: @station.id}).where.not(closed_at: nil)
    presenter = RentBikesPresenter.wrap(rents)
    @rents = presenter

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('History', station_history_path(@station), 'active')
    ]
  end
end
