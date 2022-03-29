module ValvesHelper
  # --------------------------------------------------------------
  def valve_form_label(valve)
    "Valve #{ valve.valve_num } - #{ valve.intake_or_exhaust }"
  end
end
