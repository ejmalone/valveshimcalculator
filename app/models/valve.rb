# == Schema Information
#
# Table name: valves
#
#  id                :integer          not null, primary key
#  gap               :integer
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
#  cylinder_id  (cylinder_id => cylinders.id)
#
class Valve < ApplicationRecord
  belongs_to :cylinder
  has_one :shim, dependent: :destroy

  INTAKE = "intake".freeze
  EXHAUST = "exhaust".freeze
end
