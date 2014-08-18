class OperatorsController < ApplicationController
  skip_before_action :fake_authenticate
  skip_before_action :authenticate

  def activate
    service = OperatorActivator.new

    begin
      service.activate(params[:id], params[:token])
    rescue
      render json: {message: 'not activated'}, status: :not_acceptable and return
    end

    render json: {message: 'activated'}, status: :ok
  end

end
