class StationsController < ApplicationController
  def index
    @breadcrumbs = [Breadcrumb.new('Stations', stations_path, 'active')]

    @stations = Station.all
  end

  def show
    @station = Station.find params[:id]
    @breadcrumbs = [Breadcrumb.new('Stations', stations_path, 'not-active'), Breadcrumb.new(@station.name, station_path(@station), 'active')]
  end
end
