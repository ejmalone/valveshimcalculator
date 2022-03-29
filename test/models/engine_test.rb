# == Schema Information
#
# Table name: engines
#
#  id                  :integer          not null, primary key
#  exhaust_max         :decimal(4, 2)
#  exhaust_min         :decimal(4, 2)
#  intake_max          :decimal(4, 2)
#  intake_min          :decimal(4, 2)
#  name                :string
#  num_cylinders       :integer
#  valves_per_cylinder :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer          not null
#
# Indexes
#
#  index_engines_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require "test_helper"

class EngineTest < ActiveSupport::TestCase
  # --------------------------------------------------------------
  setup do
    @cylinders = 2
    @valves_per_cylinder = 2
    @engine = Engine.create(user: users(:one), num_cylinders: @cylinders, valves_per_cylinder: @valves_per_cylinder)
  end

  # --------------------------------------------------------------
  test "engine has appropriate number of cylinders" do
    assert_equal @engine.cylinders.count, @cylinders
  end

  # --------------------------------------------------------------
  test "engine has appropriate number of valves" do
    assert_equal @engine.cylinders.map(&:valves).flatten.count, @valves_per_cylinder * 2
  end
end
