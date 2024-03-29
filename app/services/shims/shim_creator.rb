# frozen_string_literal: true

# creates or updates shims and sets valve gaps from an all-in-one form
module Shims
  class ShimCreator
    # --------------------------------------------------------------
    # user [User] owner of this engine and its valves & shims
    # parameters [Hash] representing [valve id] -> { thickness: [int], gap: [int] }
    def initialize(user, parameters)
      @user = user
      @parameters = parameters
    end

    # --------------------------------------------------------------
    def create
      @parameters.each do |valve_id, _|
        valve = Valve.joins(cylinder: :engine).where(valves: { id: valve_id.to_i }, engines: { userable: @user }).last
        Shim.create_for_engine!(valve, @parameters[valve_id][:thickness].to_i)
        valve.update(gap: @parameters[valve_id][:gap].to_d)
      end
    end

    # --------------------------------------------------------------
    def update(valve_adjustment)
      @parameters.each do |valve_id, _|
        valve = Valve.joins(cylinder: :engine).where(valves: { id: valve_id.to_i }, engines: { userable: @user }).last
        valve_adjustment.set_gap(valve, @parameters[valve_id][:gap].to_d)
      end

      valve_adjustment.update(status: ValveAdjustment::PENDING)
    end
  end
end
