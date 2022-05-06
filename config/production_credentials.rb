if ENV['RAILS_ENV'] == "production" && ENV['AWS_REGION'] && !ENV['DISABLE_AWS_SECRETS']
  # Load env vars before Rails is loaded
  require 'aws-sdk-secretsmanager'

  prefix = "prod/MotorcycleShims/"
  client = Aws::SecretsManager::Client.new(region: ENV['AWS_REGION'])

  ENV["RAILS_MASTER_KEY"] = JSON.parse(client.get_secret_value(secret_id: "#{ prefix }rails").secret_string)["RAILS_MASTER_KEY"]

  db_data = JSON.parse(client.get_secret_value(secret_id: "#{ prefix }db").secret_string)
  ENV["DB_HOST"] = db_data["host"]
  ENV["DATABASE"] = db_data["dbname"]
  ENV["DB_USER"] = db_data["username"]
  ENV["DB_PASSWORD"] = db_data["password"]
end
