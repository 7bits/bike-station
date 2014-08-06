class PushSender
  def initialize(api_key)
    @gcm = GCM.new(api_key)
  end

  def send_notification_to(bike, data)
    response = @gcm.send_notification([bike.registration_id], data)
  end
end
