class Api::V1::StationsController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format =~ %r{application/json} }
  respond_to :json

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
