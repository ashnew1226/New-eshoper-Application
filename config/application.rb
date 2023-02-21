require_relative "boot"

require "rails/all"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eshoper
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    # config_file = Rails.application.config_for(:application)

    # Load dotenv only in development or test environment
    # if ['development'].include? ENV['RAILS_ENV']
    #   Dotenv::Railtie.load
    # end
    # Configuration for the application, engines, and railties goes here.
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    # config.active_storage.variant_processor = :mini_magick

    config.time_zone = "Mumbai"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
