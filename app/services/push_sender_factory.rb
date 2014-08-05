class PushSenderFactory
  def self.build
    if Rails.env.production?
      PushSender.new Rails.application.secrets.gcm_api_key
    else
      FakePushSender.new
    end
  end
end