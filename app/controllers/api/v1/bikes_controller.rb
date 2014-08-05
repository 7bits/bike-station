class Api::V1::BikesController < ApplicationController
  def register
    push_sender = PushSender.new
    @bike = Bike.find_by(params[:uuid])
    if @bike.nil?
      render json: {status: :not_found, message: 'Your bike is not registered'}
    else
      bike.update_attribute(:registration_id, params[:registration_id])
    end
  end
end