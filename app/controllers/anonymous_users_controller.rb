# frozen_string_literal: true

class AnonymousUsersController < ApplicationController
  # TODO: better naming on these methods

  # --------------------------------------------------------------
  def token
    return unless current_user.present?
    redirect_to :root, notice: 'You are already signed in'
  end

  # --------------------------------------------------------------
  def sign_up_anonymous
    if current_user.present?
      redirect_to :root, notice: 'You are already signed in'
      return
    elsif anonymous_user&.engines&.blank?
      redirect_to :root, notice: 'Create an engine if you want to proceed'
      return
    end

    session[:user_return_to] = associate_new_user_path
    redirect_to new_user_registration_url
  end

  # --------------------------------------------------------------
  def associate_new_user
    if current_user.blank?
      redirect_to :root, notice: 'You need to create an account to proceed'
      return
    elsif anonymous_user&.engines&.blank?
      redirect_to :root, notice: 'Create an engine if you want to proceed'
      return
    end

    ActiveRecord::Base.transaction do
      Engine.where(userable: anonymous_user).update_all(userable_type: 'User', userable_id: current_user.id)
      anonymous_user.update(user: current_user)
      session.delete(:anonymous_user)
      redirect_to :root, notice: 'Your engines have been added to your account'
    rescue StandardError => e
      logger.debug("Error associating user #{anonymous_user.id} to #{current_user.id}: #{e.message}")
      redirect_to :root, alert: 'An error occurred, please try again'
    end
  end

  # --------------------------------------------------------------
  def restart
    anonymous_user = AnonymousUser.where(token: params[:token]).first

    if params[:token].blank? || anonymous_user.blank?
      redirect_to :root, notice: 'Please log in to continue'
      return
    end

    session[:anonymous_user] = anonymous_user.token
    redirect_to :root, notice: 'Welcome back'
  end
end
