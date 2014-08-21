require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SmartBike
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Novosibirsk'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
    config.i18n.available_locales = :ru
    config.generators do |g|
      g.test_framework      :rspec, fixture: true, view_specs: false, routing_specs: false, helper_specs: false, controller_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.helper false
      g.stylesheets false
      g.javascripts false
    end
    config.active_record.schema_format = :sql

    config.action_mailer.default_url_options = { host: 'console.smart-bikes.ru' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default :charset => 'utf-8'
    config.action_mailer.smtp_settings = {
        :address              => 'smtp.yandex.ru',
        :port                 => 25,
        :domain               => 'smart-bikes.ru',
        :user_name            => Rails.application.secrets.mail_user_name,
        :password             => Rails.application.secrets.mail_user_pwd,
        :authentication       => :login,
        :enable_starttls_auto => true
    }
  end
end
