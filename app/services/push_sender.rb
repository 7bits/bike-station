class PushSender
  def initializer(api_key)
    @gcm = GCM.new(gcm_api_key)
  end

  def send_notification_to(bike, data)
    response = @gcm.send_notification([bike.registration_id], data)
  end
end
