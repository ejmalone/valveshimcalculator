# frozen_string_literal: true

class UptimeController < ApplicationController
  layout false

  def check
    render plain: "OK"
  end
end