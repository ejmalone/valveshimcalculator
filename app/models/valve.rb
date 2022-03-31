# == Schema Information
#
# Table name: valves
#
#  id                :bigint           not null, primary key
#  gap               :decimal(4, 2)
#  intake_or_exhaust :string
#  valve_num         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  cylinder_id       :integer          not null
#
# Indexes
#
#  index_valves_on_cylinder_id  (cylinder_id)
#
# Foreign Keys
#
#  fk_rails_...  (cylinder_id => cylinders.id)
#
class Valve < ApplicationRecord
  INTAKE = 'intake'.freeze
  EXHAUST = 'exhaust'.freeze

  belongs_to :cylinder
  has_one :shim, dependent: :destroy

  # valves can have empty gap on creation via Engine#create_internals
  validates :gap, inclusion: 0.01..15.0, unless: proc { |v| v.gap.blank? }
end
