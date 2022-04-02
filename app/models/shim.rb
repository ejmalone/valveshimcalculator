# frozen_string_literal: true

# == Schema Information
#
# Table name: shims
#
#  id         :bigint           not null, primary key
#  thickness  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  engine_id  :bigint
#  valve_id   :integer
#
# Indexes
#
#  index_shims_on_engine_id  (engine_id)
#  index_shims_on_valve_id   (valve_id)
#
# Foreign Keys
#
#  fk_rails_...  (engine_id => engines.id)
#
class Shim < ApplicationRecord
  SIZE_LIMITS = (100..500).freeze

  belongs_to :valve, optional: true
  belongs_to :engine

  validates :thickness, inclusion: { in: SIZE_LIMITS }

  scope :unused_for_engine, ->(engine) { where(engine_id: engine.id, valve_id: nil) }

  # --------------------------------------------------------------
  def self.create_for_engine!(valve, thickness)
    create!(valve: valve, engine: valve.cylinder.engine, thickness: thickness)
  end
end
