class OperatorAuthenticator
  DEV_UID = -1

  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = Rails.env.production? ?
      auth_hash :
      Struct.new(:provider, :info, :credentials).new('fake', {'uid' => DEV_UID}, { 'token' => '111111'})
  end

  def model
    @model ||= authenticate_operator
  end

  private

  def authenticate_operator
    operator = Operator.find_or_create_by(uid: @auth_hash.info['uid'], provider: @auth_hash.provider)
    operator.update_attributes authentication_token: @auth_hash.credentials['token'], url: select_url
    operator
  end

  def select_url
    return 'fake.smart-bikes.ru' if @auth_hash.provider == 'fake'

    if @auth_hash.provider == 'google_oauth2'
      @auth_hash.extra['raw_info']['profile']
    else
      @auth_hash.info['urls']['Vkontakte']
    end
  end
end