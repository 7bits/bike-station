class Api::V1::BikesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json

  def register
    push_sender = PushSender.new
    @bike = Bike.find_by(uuid: params[:uuid])
    if @bike.nil?
      render json: {status: :not_found, message: 'Your bike is not registered'}
    else
      @bike.update_attribute(:registration_id, params[:registration_id])
      render json: {status: :ok}
    end
  end
end