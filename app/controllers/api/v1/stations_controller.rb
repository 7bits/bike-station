class Api::V1::StationsController < ApplicationController
  def index
    stations = Station.all
    presenter = MapStationPresenter.wrap(stations)

    render json: {stations: presenter}, status: :ok
  end
end
