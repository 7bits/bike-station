class FakePushSender
  def send_notification_to(bike, data)
    msg = {registration_id: [bike.registration_id]}.merge(data)
    Rails.logger.info "PUSH #{msg}"
  end
end
