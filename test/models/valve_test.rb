# frozen_string_literal: true

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
require 'test_helper'

class ValveTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
