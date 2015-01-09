require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChallengeApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths += %W(#{config.root}/app/workers)

    config.action_mailer.default_url_options = { host: "hotcode.pl:3000"}
    config.action_mailer.default_options = {
      from: "sjmr@op.pl"
    }
    config.action_mailer.delivery_method = :smtp
    smtp = {
      address: ENV['SMTP_ADDRESS'],
      port: ENV['SMTP_PORT'],
      domain: ENV['SMTP_DOMAIN'],
      user_name: ENV['SMTP_USER'],
      password: ENV['SMTP_PASSWORD'],
      authentication: ENV['SMTP_AUTHENTICATION'],
      enable_starttls_auto: ENV['SMTP_TLSAUTO']
    }
    config.action_mailer.smtp_settings = smtp

    config.generators do |g|
      g.template_engine :slim
    end
  end
end
