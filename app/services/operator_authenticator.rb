class OperatorAuthenticator
  DEV_EMAIL = 'dev@smart-bikes.ru'

  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = Rails.env.production? ?
      auth_hash :
      Struct.new(:info, :credentials).new({'email' => DEV_EMAIL}, { 'token' => '111111'})
  end

  def model
    @model ||= authenticate_operator
  end

  private

  def authenticate_operator
    operator = Operator.find_or_create_by(email: @auth_hash.info['email'])
    operator.update_attributes authentication_token: @auth_hash.credentials['token']
    operator
  end
end