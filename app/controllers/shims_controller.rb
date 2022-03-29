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
    params[:valves].each do |valve_id, size_mm|
      Shim.create(size_mm: size_mm.to_i, valve: Valve.find(valve_id.to_i))
    end

    redirect_to engine_path(@engine)
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
