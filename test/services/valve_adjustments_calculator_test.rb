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
    assert_equal 'red', @calculator.valve_style(@valve)
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
      assert_equal 155, @calculator.apply_shims[valve].thickness
    end
  end
end
