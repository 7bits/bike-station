class SessionController < ApplicationController
  skip_before_action :fake_authenticate
  skip_before_action :authenticate

  def create
    operator = OperatorAuthenticator.new(request.env['omniauth.auth']).model

    if operator
      sign_in(operator)
      flash[:success] = "Successfully authenticated from #{operator.provider} account."
      redirect_to :root
    else
      flash[:error] = 'Please finish registration'
      redirect_to :root
    end
  end

  def destroy
    sign_out
    redirect_to :root
  end
end
