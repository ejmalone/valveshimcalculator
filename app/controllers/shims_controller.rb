# frozen_string_literal: true

class ShimsController < ApplicationController
  before_action :load_engine, only: %i[edit_all create_all update_all]
  before_action :redirect_to_engine_if_created, only: %i[create_all]

  def new; end

  # --------------------------------------------------------------
  # Adds shims to valves an sets valve gaps in a single form
  # @see create_all and update_all for PUT of this form
  def edit_all; end

  # --------------------------------------------------------------
  # Updating shims is part of a valve adjustment, so we'll redirect back to that page
  def update_all
    ActiveRecord::Base.transaction do
      shim_creator = Shims::ShimCreator.new(current_user, params[:valve])
      shim_creator.update(@engine, params[:valve_adjustment_id])
    rescue StandardError => e
      logger.debug("Error updating shims/updating valves: #{e.message}")
      redirect_to edit_all_engine_shims_path(@engine, update: true), flash: { alert: 'One or more shims is invalid' }
    else
      redirect_to adjust_engine_valve_adjustment_path(@engine, valve_adjustment)
    end
  end

  # --------------------------------------------------------------
  # Adds shims to valves an sets valve gaps in a single form
  def create_all
    ActiveRecord::Base.transaction do
      shim_creator = Shims::ShimCreator.new(current_user, params[:valve])
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
  # ensure we don't try to generate shims & populate gaps if already done
  def redirect_to_engine_if_created
    redirect_to engine_path(@engine) unless @engine.lacks_shims?
  end

  # --------------------------------------------------------------
  # --------------------------------------------------------------
  def load_engine
    @engine = Engine.where(id: params[:engine_id], user_id: current_user.id).last
  end
end
