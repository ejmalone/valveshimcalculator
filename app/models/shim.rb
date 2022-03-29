# == Schema Information
#
# Table name: shims
#
#  id         :integer          not null, primary key
#  size_mm    :integer
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
#  valve_id  (valve_id => valves.id)
#
class Shim < ApplicationRecord
  belongs_to :valve
end
