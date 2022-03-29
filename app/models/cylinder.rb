# == Schema Information
#
# Table name: cylinders
#
#  id           :integer          not null, primary key
#  cylinder_num :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  engine_id    :integer          not null
#
# Indexes
#
#  index_cylinders_on_engine_id  (engine_id)
#
# Foreign Keys
#
#  engine_id  (engine_id => engines.id)
#
class Cylinder < ApplicationRecord
  belongs_to :engine
  has_many :valves, dependent: :destroy
end
