# frozen_string_literal: true

class UptimeController < ApplicationController
  layout false

  def check
    render plain: "OK"
  end

  def test_exception
    raise params[:exception] || "This is an exception"
  end
end