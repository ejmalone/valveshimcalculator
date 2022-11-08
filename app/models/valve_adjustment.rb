# frozen_string_literal: true

# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :bigint           not null, primary key
#  adjustment_date :date
#  initial         :json
#  mileage         :integer
#  notes           :text
#  result          :json
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  engine_id       :bigint           not null
#
# Indexes
#
#  index_valve_adjustments_on_engine_id  (engine_id)
#
# Foreign Keys
#
#  fk_rails_...  (engine_id => engines.id)
#
class ValveAdjustment < ApplicationRecord
  include AdjustmentCommon

  IN_PROGRESS = 'in progress'
  NEEDS_GAPS = 'needs gaps'
  PENDING = 'pending'
  COMPLETE = 'complete'

  belongs_to :engine

  scope :most_recent, -> { order('adjustment_date DESC') }
  scope :complete, -> { where(status: COMPLETE) }
  scope :incomplete, -> { where(status: [nil, PENDING, NEEDS_GAPS]) }
  scope :current, -> { most_recent.incomplete }

  before_create :save_initial
  before_create :set_in_progress

  # --------------------------------------------------------------
  def pending?
    status == PENDING
  end

  # --------------------------------------------------------------
  def incomplete?
    [ IN_PROGRESS, PENDING, NEEDS_GAPS, nil ].include? status
  end

  # --------------------------------------------------------------
  def completed?
    status == COMPLETE
  end

  # --------------------------------------------------------------
  def needs_gaps_measured?
    status == NEEDS_GAPS
  end

  # --------------------------------------------------------------
  def unused_shims
    Shim.where(id: result["unused_shims"])
  end

  # --------------------------------------------------------------
  def new_shim(valve)
    entry = result["valves"].detect { |v| v["index"] == serialized_valve_index(valve) }
    Shim.find(entry["shim_id"])
  end

  # --------------------------------------------------------------
  def new_gap(valve)
    entry = result["valves"].detect { |v| v["index"] == serialized_valve_index(valve) }
    entry["gap"].to_d
  end

  # --------------------------------------------------------------
  def update_valve(valve, shim)
    entry = result["valves"].detect { |v| v["index"] == serialized_valve_index(valve) }
    entry["gap"] = nil
    entry["shim_id"] = shim.id
  end

  # --------------------------------------------------------------
  def update_gap(valve, gap)
    entry = result["valves"].detect { |v| v["index"] == serialized_valve_index(valve) }
    entry["gap"] = gap
  end

  # --------------------------------------------------------------
  def update_unused_shims(unused_shims)
    result["unused_shims"] = unused_shims.map(&:thickness)
  end

  # --------------------------------------------------------------
  private
  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def serialize_engine
    @serialize_engine = begin
      {
        unused_shims: Shim.unused_for_engine(engine).map(&:id),
        valves: engine.cylinders.map(&:valves).flatten.map do |valve|
          {
            index: serialized_valve_index(valve),
            shim_id: valve.shim.id,
            gap: valve.gap
          }
        end
      }
    end
  end

  # --------------------------------------------------------------
  def save_initial
    self.initial = serialize_engine
    self.result = serialize_engine
  end

  # --------------------------------------------------------------
  def set_in_progress
    self.status = ValveAdjustment::IN_PROGRESS
  end
end
