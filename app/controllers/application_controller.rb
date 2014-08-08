class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_operator, :operator_signed_in?
  before_action :fake_authenticate
  before_action :authenticate

  private

  def fake_authenticate
    # !!!DEVELOPMENT!!!
    if Rails.env.development?
      @current_operator ||= OperatorAuthenticator.new({}).model
      sign_in(@current_operator)
    end
  end

  def authenticate
    if current_operator
      unless has_permissions?(current_operator)
        flash[:warning] = 'Your account is not activated yet.'
        redirect_to :root
      end
    else
      flash[:danger] = 'You need to sign in or sign up before continuing.'
      redirect_to :root
    end
  end

  def has_permissions?(operator)
    true if operator && operator.approved
  end

  def sign_in(operator)
    session[:operator_id] = operator.id
  end

  def sign_out
    session[:operator_id] = nil
  end

  def operator_signed_in?
    true if current_operator
  end

  def current_operator
    @current_operator ||= Operator.find_by(id: session[:operator_id]) if session[:operator_id]
  rescue
    @current_operator = nil
  end
end
