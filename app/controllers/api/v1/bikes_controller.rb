class Api::V1::BikesController < ApplicationController
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
    rescue BikeNotFound => ex
      render json: {message: 'Bike not found'}, status: :not_found and return
    rescue BikeRegistrationError => ex
      render json: {message: ex.message}, status: :unprocessable_entity and return
    end
    
    render json: {message: 'Successfull registration'}, status: :ok
  end
end