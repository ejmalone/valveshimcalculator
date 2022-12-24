# frozen_string_literal: true

# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :bigint           not null, primary key
#  adjustment_date :date
#  mileage         :integer
#  notes           :text
#  status          :string
#  valve_state     :json
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
  include Calculator
  include ValveState

  has_paper_trail

  IN_PROGRESS = 'in progress'
  NEEDS_GAPS = 'needs gaps'
  PENDING = 'pending'
  COMPLETE = 'complete'

  belongs_to :engine

  scope :most_recent, -> { order('adjustment_date DESC') }
  scope :complete, -> { where(status: COMPLETE) }
  scope :incomplete, -> { where(status: [nil, PENDING, NEEDS_GAPS]) }
  scope :current, -> { most_recent.incomplete }

  before_create :set_in_progress

  # --------------------------------------------------------------
  def pending?
    status == PENDING
  end

  # --------------------------------------------------------------
  def incomplete?
    [IN_PROGRESS, PENDING, NEEDS_GAPS, nil].include? status
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
  # Move the valve_state values into associated models (valve, shim)
  def complete!
    ActiveRecord::Base.transaction do
      Shim.where(id: valve_state['unused_shims'].map { |shim| shim['id'] }).update_all(valve_id: nil)

      valve_state['valves'].each do |valve_info|
        Valve.where(id: valve_info['id']).first.update(gap: valve_info['gap'])
        Shim.where(id: valve_info['shim_id']).first.update(valve_id: valve_info['id'])
      end

      update(status: ValveAdjustment::COMPLETE)
    end
  end

  # --------------------------------------------------------------
  private

  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def set_in_progress
    self.status = ValveAdjustment::IN_PROGRESS
  end
end
