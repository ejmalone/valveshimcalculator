# frozen_string_literal: true

class EnginesController < ApplicationController
  before_action :load_engine, only: %i[ show edit update destroy ]

  # --------------------------------------------------------------
  # GET /engines or /engines.json
  def index
    @engines = Engine.where(userable: current_or_anon_user)
  end

  # --------------------------------------------------------------
  # GET /engines/1 or /engines/1.json
  def show
    @latest_adjustment = @engine.valve_adjustments.most_recent.first
  end

  # --------------------------------------------------------------
  # GET /engines/new
  def new
    @engine = Engine.new(userable: current_user || anonymous_user(create: true))
  end

  # --------------------------------------------------------------
  # GET /engines/1/edit
  def edit; end

  # --------------------------------------------------------------
  # POST /engines or /engines.json
  def create
    if current_user.blank?
      verified = verify_recaptcha(action: Recaptcha::CREATE_ANON_ENGINE, minimum_score: Recaptcha::ANON_ENGINE_THRESHOLD)
      unless verified
        logger.debug("Failed to create user, reply: #{ recaptcha_reply.inspect }, error: #{ flash[:recaptcha_error] }")
        redirect_to new_user_registration_url, notice: "Please create an account to continue"
        return
      end
    end

    @engine = Engine.new(engine_params)
    @engine.userable = current_or_anon_user

    respond_to do |format|
      if @engine.save
        format.html { redirect_to edit_all_engine_shims_url(@engine), notice: 'Engine was successfully created.' }
        format.json { render :show, status: :created, location: @engine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # --------------------------------------------------------------
  # PATCH/PUT /engines/1 or /engines/1.json
  def update
    respond_to do |format|
      if @engine.update(engine_params)
        format.html { redirect_to engine_url(@engine), notice: 'Engine was successfully updated.' }
        format.json { render :show, status: :ok, location: @engine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # --------------------------------------------------------------
  # DELETE /engines/1 or /engines/1.json
  def destroy
    @engine.destroy

    respond_to do |format|
      format.html { redirect_to engines_url, notice: 'Engine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # --------------------------------------------------------------
  private

  # --------------------------------------------------------------

  # --------------------------------------------------------------
  # Use callbacks to share common setup or constraints between actions.
  def load_engine
    @engine = Engine.where(id: params[:id], userable: current_or_anon_user).last
  end

  # --------------------------------------------------------------
  # Only allow a list of trusted parameters through.
  def engine_params
    params.require(:engine).permit(:num_cylinders, :valves_per_cylinder, :name, :intake_min, :intake_max, :exhaust_min,
                                   :exhaust_max)
  end
end
