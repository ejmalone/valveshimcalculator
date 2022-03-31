# frozen_string_literal: true

# creates shims and sets valve gaps based on a form with parameters [valve id] -> { size_mm: [int], gap: [int] }
module Shim
  class Creator
    # --------------------------------------------------------------
    def initialize(parameters)
      @parameters = parameters
    end

    # --------------------------------------------------------------
    def call
      @parameters.each do |valve_id, _|
        valve = Valve.find(valve_id.to_i)
        Shim.create!(size_mm: params[:valve][valve_id][:size_mm].to_i, valve: valve)
        valve.update(gap: params[:valve][valve_id][:gap].to_d)
      end
    end
  end
end
