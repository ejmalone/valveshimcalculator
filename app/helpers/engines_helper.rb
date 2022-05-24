# frozen_string_literal: true

module EnginesHelper
  def engine_name(engine)
    engine.nickname || "#{ engine.make } #{ engine.model }".strip!
  end
end
