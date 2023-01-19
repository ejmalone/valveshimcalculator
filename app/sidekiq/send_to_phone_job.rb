# frozen_string_literal: true

require 'twilio-ruby'

class SendToPhoneJob
  include Sidekiq::Job

  def perform(phone_number, url)
    client = Twilio::REST::Client.new(Rails.application.credentials.twilio.account_sid,
                                      Rails.application.credentials.twilio.token)

    client.messages.create(
      from: Rails.application.credentials.twilio.phone_number,
      to: phone_number,
      body: "Here is the URL you requested #{url}"
    )
  end
end
