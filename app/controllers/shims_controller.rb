# frozen_string_literal: true

class ShimsController < ApplicationController
  before_action :load_engine, on: %i[edit_all create_all]
  before_action :redirect_to_engine_if_created, on: %i[edit_all create_all]

  # --------------------------------------------------------------
  # Adds shims to valves an sets valve gaps in a single form
  # @see create_all for PUT of this form
  def edit_all; end

  # --------------------------------------------------------------
  def update; end

  # --------------------------------------------------------------
  # Adds shims to valves an sets valve gaps in a single form
  def create_all
    ActiveRecord::Base.transaction do
      shim_creator = Shims::ShimCreator.new(params[:valve])
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
    @engine = Engine.includes_shims.where(id: params[:engine_id]).last
  end
end
