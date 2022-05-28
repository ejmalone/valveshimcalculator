# frozen_string_literal: true

class UptimeController < ApplicationController
  layout false

  def check
    render plain: "OK"
  end

  def test_exception
    raise params[:exception] || "This is a test exception at #{ Time.zone.now }"
  rescue => e
    Rollbar.error(e)
  ensure
    render plain: "Error sent"
  end
end