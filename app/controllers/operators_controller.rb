class OperatorsController < ApplicationController
  skip_before_action :fake_authenticate
  skip_before_action :authenticate

  def activate
    service = OperatorActivator.new

    begin
      service.activate(params[:id], params[:token])
    rescue
      render json: {message: 'Error: not activated'}, status: :not_acceptable and return
    end

    render json: {message: 'activated'}, status: :ok
  end

  def deactivate
    service = OperatorActivator.new

    begin
      service.deactivate(params[:id], params[:token])
    rescue
      render json: {message: 'Error: not deactivated'}, status: :not_acceptable and return
    end

    render json: {message: 'deactivated'}, status: :ok
  end
end
