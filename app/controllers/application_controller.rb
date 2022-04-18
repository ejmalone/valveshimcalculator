# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def index; end

  # --------------------------------------------------------------
  def enable_debug
    session[:debug] = true
    redirect_to :root
  end

  # --------------------------------------------------------------
  def disable_debug
    session.delete('debug')
    redirect_to :root
  end

  # --------------------------------------------------------------
  helper_method def current_or_anon_user
    current_user || anonymous_user
  end

  # --------------------------------------------------------------
  helper_method def anonymous_user(create: false)
    if session[:anonymous_user].present?
      user = AnonymousUser.where(token: session[:anonymous_user]).last

      if user
        user
      elsif create
        create_anonymous_user
      end
    elsif create
      create_anonymous_user
    end
  end

  # --------------------------------------------------------------
  private

  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def create_anonymous_user
    user = AnonymousUser.create
    session[:anonymous_user] = user.token
    user
  end
end
