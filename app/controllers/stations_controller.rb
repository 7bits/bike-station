class StationsController < ApplicationController
  def index
    @stations = Station.all

    @breadcrumbs = [Breadcrumb.new('Stations', stations_path, 'active')]
  end

  def show
    @station = Station.find params[:id]
    @total_cost = CostCounter.new.calculate_total_cost(@station)

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'active')
    ]
  end

  def history
    @station = Station.find params[:id]

    histories = @station.rents_histories
    @presenter = RentsHistoryPresenter.wrap(histories)

    @breadcrumbs = [
        Breadcrumb.new('Stations', stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new('History', history_station_path(@station), 'active')
    ]
  end
end
