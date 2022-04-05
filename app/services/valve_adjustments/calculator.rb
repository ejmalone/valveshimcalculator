# frozen_string_literal: true

module ValveAdjustments
  class Calculator
    attr_accessor :engine, :valves

    # --------------------------------------------------------------
    def initialize(engine)
      @engine = engine
      @valves = engine.cylinders.map(&:valves).flatten
    end

    # --------------------------------------------------------------
    # The real logic of determining how to use the available shims to finish an adjustment
    # rubocop:disable Metrics/AbcSize
    def apply_shims
      @apply_shims ||= begin
        valves_to_shims = {}

        available_shims_for_valves.each do |valve, shims|
          next if shims.blank?

          available_shims = available_shims_for_valves[valve] - valves_to_shims.values.uniq

          next if available_shims.blank?

          best_shim = available_shims.min_by { |shim| new_shim_thickness_range(valve).first - shim.thickness }

          valves_to_shims[valve] = best_shim
        end

        valves_to_shims
      end
    end
    # rubocop:enable Metrics/AbcSize

    # --------------------------------------------------------------
    def available_shims_for_valves
      @available_shims_for_valves ||= begin
        results = {}
        shims = @engine.shims

        @valves.each do |valve|
          results[valve] = []
          shim_range = new_shim_thickness_range(valve)
          shims.each do |shim|
            results[valve] << shim if shim_range.cover? shim.thickness
          end
        end

        results
      end
    end

    # --------------------------------------------------------------
    def new_shim_thickness(valve)
      if well_in_spec?(valve)
        ' n/a '
      else
        # TODO: round to nearest 5
        new_shim_thickness_range(valve).first
      end
    end

    # --------------------------------------------------------------
    # rubocop:disable Metrics/AbcSize
    def new_shim_thickness_range(valve)
      ((valve.gap - max_gap(valve) + valve.shim.thickness.to_d / 100) * 100)..
        ((valve.gap - min_gap(valve) + valve.shim.thickness.to_d / 100) * 100)
    end
    # rubocop:enable Metrics/AbcSize

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
    def min_gap(valve)
      valve_range(valve).first
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
