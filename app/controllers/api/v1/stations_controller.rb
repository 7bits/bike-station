class Api::V1::StationsController < Api::ApiController
  def map
    stations = Station.all
    presenter = MapStationPresenter.wrap(stations)

    render json: {stations: presenter}, status: :ok
  end

  def index
    stations = Station.all
    presenter = StationPresenter.wrap(stations)

    render json: presenter, status: :ok
  end
end
