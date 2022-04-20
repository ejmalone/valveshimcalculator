# frozen_string_literal: true

class ValveAdjustmentsController < ApplicationController
  before_action :load_engine
  before_action :load_valve_adjustment, except: %i[ index new create ]
  before_action :set_breadcrumb

  # --------------------------------------------------------------
  # GET /valve_adjustments or /valve_adjustments.json
  def index
    breadcrumb 'All valve adjustments'
    @valve_adjustments = @engine.valve_adjustments
  end

  # --------------------------------------------------------------
  # GET /valve_adjustments/1 or /valve_adjustments/1.json
  def show; end

  # --------------------------------------------------------------
  # GET /valve_adjustments/new
  def new
    breadcrumb 'Start a valve adjustment'
    @engine = Engine.find(params[:engine_id])
    @valve_adjustment = ValveAdjustment.new
  end

  # --------------------------------------------------------------
  # GET /valve_adjustments/1/edit
  def adjust
    breadcrumb @valve_adjustment.pending? ? 'Confirming adjustment' : 'Selecting new shims'

    @valve_shim_calculator = ValveAdjustments::Calculator.new(@engine)

    return unless @valve_adjustment.needs_gaps_measured?

    redirect_to edit_all_engine_shims_url(@engine, update: true, valve_adjustment_id: @valve_adjustment.id),
                notice: 'New gaps need to be measured'
  end

  # --------------------------------------------------------------
  # POST /valve_adjustments or /valve_adjustments.json
  def create
    @valve_adjustment = ValveAdjustment.new(valve_adjustment_params)
    @valve_adjustment.engine = @engine

    respond_to do |format|
      if @valve_adjustment.save
        format.html do
          redirect_to adjust_engine_valve_adjustment_url(@engine, @valve_adjustment),
                      notice: 'Valve adjustment was successfully created.'
        end
        format.json { render :show, status: :created, location: @valve_adjustment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @valve_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # --------------------------------------------------------------
  # PATCH/PUT /valve_adjustments/1 or /valve_adjustments/1.json
  def update
    respond_to do |format|
      if @valve_adjustment.update(valve_adjustment_params)
        format.html do
          redirect_to engine_valve_adjustment_url(@engine, @valve_adjustment),
                      notice: 'Valve adjustment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @valve_adjustment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @valve_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # --------------------------------------------------------------
  # PATCH/PUT /valve_adjustments/1/update_shims or /valve_adjustments/1/update_shims.json
  def update_shims
    @valve_shim_calculator = ValveAdjustments::Calculator.new(@engine)
    @valve_shim_calculator.apply_shims
    @valve_adjustment.update(status: ValveAdjustment::NEEDS_GAPS)

    respond_to do |format|
      format.html do
        redirect_to edit_all_engine_shims_url(@engine, update: true, valve_adjustment_id: @valve_adjustment), status: :see_other,
                                                                                                              notice: 'Now measure the new gaps'
      end
      format.json { render :show, status: :ok, location: @valve_adjustment }
    end
  end

  # --------------------------------------------------------------
  # Creates a shim and returns to the current valve adjustment
  def create_shim
    @shim = Shim.create!(engine: @engine, thickness: params[:shim][:thickness])
    redirect_to adjust_engine_valve_adjustment_url(@engine, @valve_adjustment.id, choose_shims: true)
  end

  # --------------------------------------------------------------
  # PATCH/PUT /valve_adjustments/1/complete or /valve_adjustments/1/complete.json
  def complete
    @valve_adjustment.update(status: ValveAdjustment::COMPLETE)

    respond_to do |format|
      format.html do
        redirect_to engine_url(@engine), status: :see_other,
                                         notice: 'Valve adjustment complete'
      end
      format.json { render :show, status: :ok, location: @valve_adjustment }
    end
  end

  # --------------------------------------------------------------
  # DELETE /valve_adjustments/1 or /valve_adjustments/1.json
  def destroy
    @valve_adjustment.destroy

    respond_to do |format|
      format.html do
        redirect_to engine_valve_adjustments_url(@engine), notice: 'Valve adjustment was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  # --------------------------------------------------------------
  private

  # --------------------------------------------------------------

  # --------------------------------------------------------------
  # Only allow a list of trusted parameters through.
  def valve_adjustment_params
    params.require(:valve_adjustment).permit(:mileage, :adjustment_date, :notes)
  end

  # --------------------------------------------------------------
  def load_valve_adjustment
    @valve_adjustment = ValveAdjustment.joins(:engine).where(id: params[:id],
                                                             engines: {
                                                               id: @engine.id
                                                             }).last
  end

  # --------------------------------------------------------------
  def load_engine
    @engine = Engine.where(id: params[:engine_id], userable: current_or_anon_user).last
  end

  # --------------------------------------------------------------
  def set_breadcrumb
    breadcrumb "My #{@engine.name}", engine_url(@engine)

    return unless @valve_adjustment.present?

    breadcrumb "#{@valve_adjustment.mileage} mile valve adjustment",
               engine_valve_adjustment_url(@engine, @valve_adjustment)
  end
end
