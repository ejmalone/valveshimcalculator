# frozen_string_literal: true

require 'test_helper'

class ValveAdjustmentsCalculatorTest < ActionDispatch::IntegrationTest
  # --------------------------------------------------------------
  def setup
    @engine = klr_with_out_of_spec_valve
    @valve = @engine.cylinders.first.valves.first
    @calculator = ValveAdjustments::Calculator.new(@engine)
  end

  # --------------------------------------------------------------
  test 'valve is out of spec' do
    assert_equal ValveAdjustments::OUT_OF_SPEC, @calculator.valve_status(@valve)
  end

  # --------------------------------------------------------------
  test 'valve adjustment thickness' do
    new_thickness = (@valve.gap - @engine.intake_max + @valve.shim.thickness.to_d / 100) * 100
    assert_equal new_thickness, @calculator.new_shim_thickness(@valve)
  end

  # --------------------------------------------------------------
  test 'choose thinnest available shim' do
    valve = @engine.cylinders.first.valves.first
    assert @calculator.out_of_spec?(valve)

    # given 0.05 gap of the out of spec valve, a 155 shim would be ideal
    @calculator.stub(:available_shims_for_valves, { valve => [Shim.new(thickness: 155), Shim.new(thickness: 165)] }) do
      assert_equal 155, @calculator.choose_shims[valve].thickness
    end
  end

  # --------------------------------------------------------------
  test 'apply thinnest shims' do
    valve = @engine.cylinders.first.valves.first
    existing_shim = valve.shim
    better_shim = Shim.create(engine_id: @engine.id, thickness: 155)

    @calculator.stub(:available_shims_for_valves, { valve => [better_shim, existing_shim] }) do
      @calculator.apply_shims(update_engine: true)

      valve.reload
      existing_shim.reload

      assert_nil existing_shim.valve_id
      assert_equal better_shim, valve.shim

      assert_equal 5, @engine.shims.count, 'started with 4 shims, and added a new one for adjustment'
    end
  end
end
