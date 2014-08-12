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
    @station = Station.find params[:id]

    rents = Rent.closed.for_station(@station.id)
    @rents = RentBikesPresenter.wrap(rents)

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('History', history_station_path(@station), 'active')
    ]
  end
end
