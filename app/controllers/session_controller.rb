class SessionController < ApplicationController
  skip_before_action :fake_authenticate
  skip_before_action :authenticate

  def create
    operator = OperatorAuthenticator.new(request.env['omniauth.auth']).model

    if operator
      sign_in(admin)
      flash[:success] = 'Successfully authenticated from google-plus account.'
      redirect_to :root
    else
      flash[:error] = 'Pleas finish registration'
      redirect_to :root
    end
  end

  def destroy
    sign_out
    redirect_to :root
  end
end
