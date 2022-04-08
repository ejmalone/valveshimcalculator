module Engines
  class Util
    def self.reset(engine_id)
      engine = Engine.find(engine_id)

      engine.cylinders.map(&:valves).flatten.each { |valve| valve.update(gap: nil) }
      engine.shims.destroy_all
      engine.valve_adjustments.destroy_all
    end
  end
end