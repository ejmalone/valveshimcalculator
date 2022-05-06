require_relative "boot"

if ENV['RAILS_ENV'] == "production" && ENV['AWS_REGION'] && !ENV['DISABLE_AWS_SECRETS']
  # Load env vars before Rails is loaded
  require 'aws-sdk-secretsmanager'

  client = Aws::SecretsManager::Client.new(region: ENV['AWS_REGION'])
  get_secret_value_response = client.get_secret_value(secret_id: "prod/MotorcyleShims/rails")
  ENV["RAILS_MASTER_KEY"] = JSON.parse(get_secret_value_response.secret_string)["RAILS_MASTER_KEY"]
end

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ValveShim
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    ActiveSupport::Inflector.inflections(:en) do |inflect|
      inflect.irregular "valve", "valves"
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
