class Api::V1::StationsController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
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
