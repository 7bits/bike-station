class Api::V1::BikesController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json

  def register
    input = BikeInput.new params
    service = BikeRegistrator.new
    
    unless input.valid?
      render json: {message: input.errors.messages}, status: :not_acceptable and return
    end

    begin
      service.register!(input)
    rescue BikeRegistrator::BikeNotFound => ex
      render json: {message: 'Bike not found'}, status: :not_found and return
    rescue BikeRegistrator::StationNotFound => ex
      render json: {message: 'Station not found'}, status: :not_found and return
    rescue BikeRegistrator::BikeRegistrationError => ex
      render json: {message: ex.message}, status: :unprocessable_entity and return
    end
    
    render json: {message: 'Successful registration'}, status: :ok
  end

  def locations
    locations = Location.all
    presenter = LocationPresenter.wrap(locations)

    render json: {locations: presenter}, status: :ok
  end

  def location
    bike = Bike.find_by uuid: params[:uuid]

    if bike
      bike.bike_locations.create(lat: params[:lat], lng: params[:lng], date: DateTime.now)
    end

    render json: {}, status: :ok
  end
end