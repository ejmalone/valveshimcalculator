module Recaptcha
  CREATE_ANON_ENGINE = 'create_engine'
  ANON_ENGINE_THRESHOLD = 0.9

  CREATE_USER = 'create_user'
  USER_THRESHOLD = 0.7
end

Recaptcha.configure do |config|
  config.site_key = '6LciPn8fAAAAAKxU7ynENPs8jg54noMKLR2r4yVe'
  config.secret_key = Rails.application.credentials.recaptcha_secret
end