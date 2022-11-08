module AdjustmentCommon
  extend ActiveSupport::Concern

  # --------------------------------------------------------------
  def serialized_valve_index(valve)
    "C#{ valve.cylinder.cylinder_num } V#{ valve.valve_num }"
  end
end