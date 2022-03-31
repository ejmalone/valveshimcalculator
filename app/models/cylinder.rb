# frozen_string_literal: true

# == Schema Information
#
# Table name: cylinders
#
#  id           :bigint           not null, primary key
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
#  fk_rails_...  (engine_id => engines.id)
#
class Cylinder < ApplicationRecord
  belongs_to :engine
  has_many :valves, dependent: :destroy
end
