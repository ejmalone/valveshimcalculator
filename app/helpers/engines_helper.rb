# frozen_string_literal: true

module EnginesHelper
  def engine_name(engine)
    name = "#{engine.make} #{engine.model}"
    name += " (#{engine.nickname})" if engine.nickname.present?
    name
  end
end
