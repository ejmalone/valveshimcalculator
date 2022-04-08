# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index; end

  # --------------------------------------------------------------
  def enable_debug
    user_session["debug"] = true
    redirect_to :root
  end

  # --------------------------------------------------------------
  def disable_debug
    user_session.delete("debug")
    redirect_to :root
  end
end
