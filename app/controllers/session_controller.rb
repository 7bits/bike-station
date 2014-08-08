class SessionController < ApplicationController
  def create
    @operator = Operator.find_by(email: params[:email])

    if OperatorAuthenticator.new(@operator).authenticate(params[:password])
      sign_in(@operator)
      redirect_to root_path
    else
      flash[:danger] = "Login failed"
      render :new
    end
  end

  def destroy

  end
end
