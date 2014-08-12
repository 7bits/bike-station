OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret
  provider :vkontakte, Rails.application.secrets.vk_client_id, Rails.application.secrets.vk_client_secret
end