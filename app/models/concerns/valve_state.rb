# frozen_string_literal: true

# Accesses and updates the `valve_state` column as a document
module ValveState
  extend ActiveSupport::Concern

  included do
    before_create :save_valve_state
  end

  # --------------------------------------------------------------
  # { 'valve' => Valve, 'gap' => float, 'shim_thickness' => int } grouped by Cylinder
  def valves_and_cylinders
    valves = Valve.includes(:cylinder).where(id: valve_state['valves'].map { |valve| valve['id'] })

    valve_state['valves'].deep_dup.each do |valve_data|
      valve_data['valve'] = valves.detect { |valve| valve.id == valve_data['id'] }
    end.group_by { |valve_data| valve_data['valve'].cylinder }
  end

  # --------------------------------------------------------------
  def unused_shims_from_state
    Shim.where(id: valve_state['unused_shims'].map { |state| state['id'] })
  end

  # --------------------------------------------------------------
  def unused_shim_thickness_from_state
    valve_state['unused_shims'].map { |state| state['thickness'] }
  end

  # --------------------------------------------------------------
  def shim_from_state(valve)
    json_valve = valve_state['valves'].detect { |v| v['id'] == valve.id }
    Shim.find(json_valve['shim_id'])
  end

  # --------------------------------------------------------------
  def gap_from_state(valve)
    json_valve = valve_state['valves'].detect { |v| v['id'] == valve.id }
    json_valve['gap'].to_d
  end

  # --------------------------------------------------------------
  def set_shim(valve, shim)
    json_valve = valve_state['valves'].detect { |v| v['id'] == valve.id }
    json_valve['gap'] = nil
    json_valve['shim_id'] = shim.id
    json_valve['shim_thickness'] = shim.thickness
  end

  # --------------------------------------------------------------
  def set_gap(valve, gap)
    json_valve = valve_state['valves'].detect { |v| v['id'] == valve.id }
    json_valve['gap'] = gap
  end

  # --------------------------------------------------------------
  def set_unused_shims(unused_shims)
    valve_state['unused_shims'] = shims_json(unused_shims)
  end

  # --------------------------------------------------------------
  private
  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def engine_json
    @serialize_engine = {
      unused_shims: shims_json(Shim.unused_for_engine(engine)),
      valves: engine.cylinders.map(&:valves).flatten.map do |valve|
        {
          id: valve.id,
          shim_id: valve.shim.id,
          shim_thickness: valve.shim.thickness,
          gap: valve.gap
        }
      end
    }
  end

  # --------------------------------------------------------------
  def shims_json(shims)
    shims.map do |shim|
      {
        id: shim.id,
        thickness: shim.thickness
      }
    end
  end

  # --------------------------------------------------------------
  def save_valve_state
    self.valve_state = engine_json
  end
end