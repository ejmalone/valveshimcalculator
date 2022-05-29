sidekiq_config = { url: ENV['REDIS_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  config.error_handlers << proc {|ex,ctx_hash| Rollbar.error(ex, context_hash: ctx_hash) }
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end