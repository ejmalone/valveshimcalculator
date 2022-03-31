# frozen_string_literal: true

# creates shims and sets valve gaps from an all-in-one form
module Shims
  class ShimCreator
    # --------------------------------------------------------------
    #  parameters [Hash] representing [valve id] -> { size_mm: [int], gap: [int] }
    def initialize(parameters)
      @parameters = parameters
    end

    # --------------------------------------------------------------
    def create
      @parameters.each do |valve_id, _|
        valve = Valve.find(valve_id.to_i)
        Shim.create!(size_mm: @parameters[valve_id][:size_mm].to_i, valve: valve)
        valve.update(gap: @parameters[valve_id][:gap].to_d)
      end
    end
  end
end
