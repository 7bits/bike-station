class PushSender
  def send_notification(input)
    bike = station.bikes.find(input.bike_id)
    registration_id = bike.registration_id
    user_info = input.user.attributes
    
    gcm_api_key = Rails.application.secrets.gcm_api_key
    gcm = GCM.new(gcm_api_key)

    response = gcm.send_notification(registration_id, user_info)
  end
end
