# frozen_string_literal: true

module ValveAdjustments
  IN_SPEC = 'in spec'.freeze
  MIN_SPEC = 'min spec'.freeze
  OUT_OF_SPEC = 'out of spec'.freeze
  UNKNOWN_SPEC = 'unknown spec'.freeze

  class Calculator
    attr_accessor :engine, :valves

    # --------------------------------------------------------------
    def initialize(engine)
      @engine = engine
      @valves = engine.cylinders.map(&:valves).flatten
      @shims_applied = false
    end

    # --------------------------------------------------------------
    def shims_applied?
      @shims_applied
    end

    # --------------------------------------------------------------
    def new_shim(valve)
      choose_shims[valve]
    end

    # --------------------------------------------------------------
    def unused_shims
      @engine.shims - choose_shims.values
    end

    # --------------------------------------------------------------
    def apply_shims
      shims = []
      choose_shims.each do |valve, shim|
        shims << shim
        Shim.find(shim.id).update(valve_id: valve.id)
        Valve.find(valve.id).update(gap: nil)
      end

      unused_shims = @engine.shims - shims
      Shim.where(id: unused_shims.map(&:id)).update_all(valve_id: nil)
    end

    # --------------------------------------------------------------
    # The real logic of determining how to use the available shims to finish an adjustment
    # rubocop:disable Metrics/AbcSize
    def choose_shims
      @choose_shims ||= begin
        @shims_applied = true
        valves_to_shims = {}

        available_shims_for_valves.each do |valve, shims|
          next if shims.blank?

          available_shims = available_shims_for_valves[valve] - valves_to_shims.values.uniq

          next if available_shims.blank?

          best_shim = available_shims.min_by { |shim| (new_shim_thickness_range(valve).first - shim.thickness).abs }

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
      ((valve.gap - max_gap(valve) + valve.shim.thickness.to_d / 100) * 100).to_i..
        ((valve.gap - min_gap(valve) + valve.shim.thickness.to_d / 100) * 100).to_i
    end
    # rubocop:enable Metrics/AbcSize

    # --------------------------------------------------------------
    def valve_status(valve)
      if well_in_spec?(valve)
        IN_SPEC
      elsif min_spec?(valve)
        MIN_SPEC
      elsif out_of_spec?(valve)
        OUT_OF_SPEC
      else
        UNKNOWN_SPEC
      end
    end

    # --------------------------------------------------------------
    def shim_status(valve, new_shim)
      if new_shim.thickness - new_shim_thickness_range(valve).first < 4
        IN_SPEC
      elsif new_shim_thickness_range(valve).last - new_shim.thickness < 4
        OUT_OF_SPEC
      else
        MIN_SPEC
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
      min_spec?(valve) && valve_range(valve).last - valve.gap <= 0.05
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
