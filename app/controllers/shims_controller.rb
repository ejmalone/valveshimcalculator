class ShimsController < ApplicationController
  before_action :load_engine, on: [ :edit_all, :create_all ]
  before_action :redirect_to_engine, on: [ :edit_all, :create_all ]

  # --------------------------------------------------------------
  def edit_all; end

  # --------------------------------------------------------------
  def update

  end

  # --------------------------------------------------------------
  def create_all
    ActiveRecord::Base.transaction do
      params[:valve].each do |valve_id, _|
        valve = Valve.find(valve_id.to_i)
        Shim.create!(size_mm: params[:valve][valve_id][:size_mm].to_i, valve: valve)
        valve.update(gap: params[:valve][valve_id][:gap].to_d)
      end
    rescue => e
      logger.debug("Error creating shims/updating valves: #{ e.message }")
      redirect_to edit_all_engine_shims_path(@engine), flash: { alert: "One or more shims is invalid" }
    else
      redirect_to engine_path(@engine)
    end
  end

  # --------------------------------------------------------------
  private
  # --------------------------------------------------------------

  def redirect_to_engine
    redirect_to engine_path(@engine) unless @engine.lacks_shims?
  end

  # --------------------------------------------------------------
  def load_engine
    @engine = Engine.includes_shims.where(id: params[:engine_id]).last
  end
end
