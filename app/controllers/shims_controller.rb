class ShimsController < ApplicationController
  before_action :set_shim, only: %i[ show edit update destroy ]

  # GET /shims or /shims.json
  def index
    @shims = Shim.all
  end

  # GET /shims/1 or /shims/1.json
  def show
  end

  # GET /shims/new
  def new
    @shim = Shim.new
  end

  # GET /shims/1/edit
  def edit
  end

  # POST /shims or /shims.json
  def create
    @shim = Shim.new(shim_params)

    respond_to do |format|
      if @shim.save
        format.html { redirect_to shim_url(@shim), notice: "Shim was successfully created." }
        format.json { render :show, status: :created, location: @shim }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shims/1 or /shims/1.json
  def update
    respond_to do |format|
      if @shim.update(shim_params)
        format.html { redirect_to shim_url(@shim), notice: "Shim was successfully updated." }
        format.json { render :show, status: :ok, location: @shim }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shims/1 or /shims/1.json
  def destroy
    @shim.destroy

    respond_to do |format|
      format.html { redirect_to shims_url, notice: "Shim was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shim
      @shim = Shim.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shim_params
      params.require(:shim).permit(:engine_id, :size_mm, :in_use, :cylinder, :valve, :valve_num)
    end
end
