# frozen_string_literal: true

class ShimsController < ApplicationController
  before_action :store_location, only: %(edit_all), if: proc { !current_or_anon_user.present? }
  before_action :semi_authenticate_user!
  before_action :load_engine, only: %i[edit_all create_all update_all]
  before_action :load_valve_adjustment, only: %i[edit_all update_all]
  before_action :redirect_to_engine_if_created, only: %i[create_all]

  def new; end

  # --------------------------------------------------------------
  # Adds shims to valves an sets valve gaps in a single form
  # @see create_all and update_all for PUT of this form
  def edit_all
    breadcrumb 'Engines', engines_url
    breadcrumb "My #{helpers.engine_name(@engine)}", engine_url(@engine)

    if params[:valve_adjustment_id].present?
      breadcrumb "#{@valve_adjustment.mileage} mile valve adjustment",
                 engine_valve_adjustment_url(@engine, @valve_adjustment)
      breadcrumb 'Measuring new gaps'
    else
      breadcrumb 'Shims'
    end
  end

  # --------------------------------------------------------------
  # Updating shims is part of a valve adjustment, so we'll redirect back to that page
  def update_all
    ActiveRecord::Base.transaction do
      shim_creator = Shims::ShimCreator.new(current_or_anon_user, params[:valve])
      shim_creator.update(@valve_adjustment)
    rescue StandardError => e
      logger.debug("Error updating shims/updating valves: #{e.message}")
      redirect_to edit_all_engine_shims_path(@engine, update: true, valve_adjustment_id: params[:valve_adjustment_id]),
                  flash: { alert: 'One or more shims is invalid' }
    else
      redirect_to adjust_engine_valve_adjustment_path(@engine, @valve_adjustment)
    end
  end

  # --------------------------------------------------------------
  # Adds shims to valves an sets valve gaps in a single form
  def create_all
    ActiveRecord::Base.transaction do
      shim_creator = Shims::ShimCreator.new(current_or_anon_user, params[:valve])
      shim_creator.create
    rescue StandardError => e
      logger.debug("Error creating shims/updating valves: #{e.message}")
      redirect_to edit_all_engine_shims_path(@engine), flash: { alert: 'One or more shims is invalid' }
    else
      redirect_to engine_path(@engine)
    end
  end

  # --------------------------------------------------------------
  private

  # --------------------------------------------------------------

  # --------------------------------------------------------------
  # allows user to return to this page after signing in, see ValveAdjustmentsController#send_to_phone
  def store_location
    store_location_for(:user, request.fullpath)
  end

  # --------------------------------------------------------------
  # ensure we don't try to generate shims & populate gaps if already done
  def redirect_to_engine_if_created
    redirect_to engine_path(@engine) unless @engine.lacks_shims?
  end

  # --------------------------------------------------------------
  def load_engine
    @engine = Engine.where(id: params[:engine_id], userable: current_or_anon_user).last
  end

  # --------------------------------------------------------------
  def load_valve_adjustment
    @valve_adjustment = ValveAdjustment.where(id: params[:valve_adjustment_id], engine: @engine).last
  end
end
