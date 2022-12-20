module AdjustmentCommon
  extend ActiveSupport::Concern

  # --------------------------------------------------------------
  def valve_json_key(valve)
    "C#{ valve.cylinder.cylinder_num } V#{ valve.valve_num }"
  end
end