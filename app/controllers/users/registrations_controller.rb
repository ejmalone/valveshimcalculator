# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  # see https://github.com/heartcombo/devise/wiki/How-To:-Use-Recaptcha-with-Devise#deviseregistrationscontroller
  def check_captcha
    verified = verify_recaptcha(action: Recaptcha::CREATE_USER, minimum_score: Recaptcha::USER_THRESHOLD)
    logger.debug("-- recaptcha: #{verified}, response: #{recaptcha_reply.inspect}")
    return if verified

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA
    set_minimum_password_length

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
      render :new
    end
  end
end
