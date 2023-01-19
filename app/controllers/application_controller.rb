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

  def adder
    AddJob.perform_async(params[:one].to_i, params[:two].to_i)
    render plain: 'added async job'
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
  def semi_authenticate_user!
    return if current_or_anon_user.present?

    redirect_to new_user_session_url, alert: 'Please sign in'
  end

  # --------------------------------------------------------------
  def create_anonymous_user
    user = AnonymousUser.create
    session[:anonymous_user] = user.token
    user
  end

  # --------------------------------------------------------------
  def breadcrumb(text, url = nil)
    @breadcrumbs ||= []
    @breadcrumbs << [text, url]
  end
end
