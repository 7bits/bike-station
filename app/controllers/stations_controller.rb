class StationsController < ApplicationController
  def index
    @stations = Station.all

    @breadcrumbs = [Breadcrumb.new(t('stations'), stations_path, 'active')]
  end

  def show
    @station = Station.find params[:id]
    @total_cost = CostCounter.new.calculate_daily_cost(@station)

    @breadcrumbs = [
        Breadcrumb.new(t('stations'), stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'active')
    ]
  end

  def history
    @station = Station.find params[:id]

    histories = @station.rents_histories
    @presenter = RentsHistoryPresenter.wrap(histories)

    @breadcrumbs = [
        Breadcrumb.new(t('stations'), stations_path, 'not-active'),
        Breadcrumb.new(@station.name, station_path(@station), 'not-active'),
        Breadcrumb.new(t('history'), history_station_path(@station), 'active')
    ]
  end
end
