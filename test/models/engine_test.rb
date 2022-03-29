require "test_helper"

class EngineTest < ActiveSupport::TestCase
  setup do
    @cylinders = 2
    @valves_per_cylinder = 2
    @engine = Engine.create(user: users(:one), num_cylinders: @cylinders, valves_per_cylinder: @valves_per_cylinder)
  end

  test "engine has appropriate number of cylinders" do
    assert_equal @engine.cylinders.count, @cylinders
  end

  test "engine has appropriate number of valves" do
    assert_equal @engine.cylinders.map(&:valves).flatten.count, @valves_per_cylinder * 2
  end
end
