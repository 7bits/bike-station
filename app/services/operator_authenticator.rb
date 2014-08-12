class OperatorAuthenticator
  DEV_UID = '-1'
  DEV_NAME = 'Developer'

  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = Rails.env.production? ?
      auth_hash :
      Struct.new(:provider, :uid, :info, :credentials).new('fake', DEV_UID, {'name' => DEV_NAME}, { 'token' => '111111'})
  end

  def model
    @model ||= authenticate_operator
  end

  private

  def authenticate_operator
    operator = Operator.find_or_create_by(uid: @auth_hash.uid, name: @auth_hash.info['name'], provider: @auth_hash.provider)
    operator.update_attributes authentication_token: @auth_hash.credentials['token'], url: select_url
    Rails.logger.info operator.attributes
    operator
  end

  def select_url
    return 'https://fake.smart-bikes.ru' if @auth_hash.provider == 'fake'

    if @auth_hash.provider == 'google_oauth2'
      @auth_hash.extra['raw_info']['profile']
    else
      @auth_hash.info['urls']['Vkontakte']
    end
  end
end