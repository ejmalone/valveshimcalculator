# frozen_string_literal: true

module ValveAdjustments
  class Calculator
    # --------------------------------------------------------------
    def initialize(engine)
      @engine = engine
    end

    # --------------------------------------------------------------
    def new_shim_thickness(valve)
      if well_in_spec?(valve)
        ' n/a '
      else
        # TODO: round to nearest 5
        (valve.gap - max_gap(valve) + valve.shim.thickness.to_d / 100) * 100
      end
    end

    # --------------------------------------------------------------
    def valve_style(valve)
      if well_in_spec?(valve)
        'green'
      elsif min_spec?(valve)
        'orange'
      elsif out_of_spec?(valve)
        'red'
      else
        'grey'
      end
    end

    # --------------------------------------------------------------
    def max_gap(valve)
      valve_range(valve).last
    end

    # --------------------------------------------------------------
    def well_in_spec?(valve)
      min_spec?(valve) && valve_range(valve).last - valve.gap < 0.05
    end

    # --------------------------------------------------------------
    def min_spec?(valve)
      valve_range(valve).cover?(valve.gap)
    end

    # --------------------------------------------------------------
    def out_of_spec?(valve)
      !min_spec?(valve)
    end

    # --------------------------------------------------------------
    def valve_range(valve)
      valve.intake? ? @engine.intake_min..@engine.intake_max : @engine.exhaust_min..@engine.exhaust_max
    end
  end
end
