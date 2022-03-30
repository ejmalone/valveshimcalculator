# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :integer          not null, primary key
#  adjustment_date :date
#  mileage         :integer
#  notes           :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  engine_id       :integer          not null
#
# Indexes
#
#  index_valve_adjustments_on_engine_id  (engine_id)
#
# Foreign Keys
#
#  engine_id  (engine_id => engines.id)
#
class ValveAdjustment < ApplicationRecord
  belongs_to :engine

  scope :most_recent, -> { order("adjustment_date DESC") }
end
