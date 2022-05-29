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
  NEEDS_GAPS = 'needs gaps'
  PENDING = 'pending'
  COMPLETE = 'complete'

  belongs_to :engine

  scope :most_recent, -> { order('adjustment_date DESC') }
  scope :complete, -> { where(status: COMPLETE) }
  scope :incomplete, -> { where(status: [nil, PENDING, NEEDS_GAPS]) }
  scope :current, -> { most_recent.incomplete }

  # --------------------------------------------------------------
  def pending?
    status == PENDING
  end

  # --------------------------------------------------------------
  def completed?
    status == COMPLETE
  end

  # --------------------------------------------------------------
  def needs_gaps_measured?
    status == NEEDS_GAPS
  end
end
