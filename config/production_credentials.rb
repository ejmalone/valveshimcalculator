if ENV['RAILS_ENV'] == "production" && ENV['AWS_REGION'] && !ENV['DISABLE_AWS_SECRETS']
  # Load env vars before Rails is loaded
  require 'aws-sdk-secretsmanager'

  prefix = "prod/MotorcycleShims/"
  client = Aws::SecretsManager::Client.new(region: ENV['AWS_REGION'])
  
  master_key_response = client.get_secret_value(secret_id: "#{ prefix }rails")
  ENV["RAILS_MASTER_KEY"] = JSON.parse(master_key_response.secret_string)["RAILS_MASTER_KEY"]

  db_response = JSON.parse(client.get_secret_value(secret_id: "#{ prefix }db"))
  ENV["DB_HOST"] = db_response["host"]
  ENV["DATABASE"] = db_response["dbname"]
  ENV["DB_USER"] = db_response["username"]
  ENV["DB_PASSWORD"] = db_response["password"]
end
