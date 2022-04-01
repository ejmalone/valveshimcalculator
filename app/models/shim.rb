# frozen_string_literal: true

# == Schema Information
#
# Table name: shims
#
#  id         :bigint           not null, primary key
#  thickness  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  valve_id   :integer          not null
#
# Indexes
#
#  index_shims_on_valve_id  (valve_id)
#
# Foreign Keys
#
#  fk_rails_...  (valve_id => valves.id)
#
class Shim < ApplicationRecord
  SIZE_LIMITS = (100..500).freeze

  belongs_to :valve

  validates :thickness, inclusion: { in: SIZE_LIMITS }
end
