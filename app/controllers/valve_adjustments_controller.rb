class ValveAdjustmentsController < ApplicationController
  before_action :set_valve_adjustment, only: %i[ show edit update destroy ]
  before_action :load_engine

  # --------------------------------------------------------------
  # GET /valve_adjustments or /valve_adjustments.json
  def index
    @valve_adjustments = @engine.valve_adjustments
  end

  # --------------------------------------------------------------
  # GET /valve_adjustments/1 or /valve_adjustments/1.json
  def show
  end

  # --------------------------------------------------------------
  # GET /valve_adjustments/new
  def new
    @engine = Engine.find(params[:engine_id])
    @valve_adjustment = ValveAdjustment.new
  end

  # --------------------------------------------------------------
  # GET /valve_adjustments/1/edit
  def edit
  end

  # --------------------------------------------------------------
  # POST /valve_adjustments or /valve_adjustments.json
  def create
    @valve_adjustment = ValveAdjustment.new(valve_adjustment_params)
    @valve_adjustment.engine = @engine

    respond_to do |format|
      if @valve_adjustment.save
        format.html { redirect_to engine_valve_adjustment_url(@engine, @valve_adjustment), notice: "Valve adjustment was successfully created." }
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
        format.html { redirect_to engine_valve_adjustment_url(@engine, @valve_adjustment), notice: "Valve adjustment was successfully updated." }
        format.json { render :show, status: :ok, location: @valve_adjustment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @valve_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # --------------------------------------------------------------
  # DELETE /valve_adjustments/1 or /valve_adjustments/1.json
  def destroy
    @valve_adjustment.destroy

    respond_to do |format|
      format.html { redirect_to engine_valve_adjustments_url(@engine), notice: "Valve adjustment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # --------------------------------------------------------------
  private
  # --------------------------------------------------------------

  # --------------------------------------------------------------
  # Use callbacks to share common setup or constraints between actions.
  def set_valve_adjustment
    @valve_adjustment = ValveAdjustment.find(params[:id])
  end

  # --------------------------------------------------------------
  # Only allow a list of trusted parameters through.
  def valve_adjustment_params
    params.require(:valve_adjustment).permit(:mileage, :adjustment_date, :notes)
  end

  # --------------------------------------------------------------
  def load_engine
    @engine = Engine.find(params[:engine_id])
  end
end
