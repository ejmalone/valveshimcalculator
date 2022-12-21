# frozen_string_literal: true

# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :bigint           not null, primary key
#  adjustment_date :date
#  mileage         :integer
#  notes           :text
#  status          :string
#  valve_state     :json
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  engine_id       :bigint           not null
#
# Indexes
#
#  index_valve_adjustments_on_engine_id  (engine_id)
#
# Foreign Keys
#
#  fk_rails_...  (engine_id => engines.id)
#
require 'test_helper'

class ValveAdjustmentTest < ActiveSupport::TestCase
  # --------------------------------------------------------------
  def setup
    @valve_adjustment = create(:valve_adjustment)
    @engine = @valve_adjustment.engine
    @out_of_spec_valve = @engine.cylinders.first.valves.first

    # minimum thickness to bring @valve into spec
    @min_thickness = @out_of_spec_valve.shim.thickness - OUT_OF_SPEC_DIFFERENCE * 100
  end

  # --------------------------------------------------------------
  test 'valve is out of spec' do
    assert @valve_adjustment.out_of_spec?(@out_of_spec_valve)
  end

  # --------------------------------------------------------------
  test 'valve adjustment thickness' do
    new_thickness = (@out_of_spec_valve.gap - @engine.intake_max + @out_of_spec_valve.shim.thickness.to_d / 100) * 100
    assert_equal new_thickness, @valve_adjustment.new_shim_thickness(@out_of_spec_valve)
  end

  # --------------------------------------------------------------
  test 'choose thinnest available shim' do
    @valve_adjustment.stub(:available_shims_for_valves, { @out_of_spec_valve => [Shim.new(thickness: @min_thickness), Shim.new(thickness: @min_thickness + 10)] }) do
      assert_equal @min_thickness, @valve_adjustment.choose_shims[@out_of_spec_valve].thickness
    end
  end

  # --------------------------------------------------------------
  test 'apply thinnest shim' do
    existing_shim = @out_of_spec_valve.shim
    in_spec_shim = Shim.create!(engine_id: @engine.id, thickness: @min_thickness)

    @valve_adjustment.stub(:available_shims_for_valves, { @out_of_spec_valve => [in_spec_shim, existing_shim] }) do
      @valve_adjustment.apply_shims
      @valve_adjustment.set_gap(@out_of_spec_valve, @engine.intake_min)
      # @valve_adjustment.save
      @valve_adjustment.complete!

      @out_of_spec_valve.reload
      existing_shim.reload

      assert_nil existing_shim.valve_id, "Shim #{existing_shim.id} should not be applied to the valve #{@out_of_spec_valve.id} any more"
      assert_equal in_spec_shim, @out_of_spec_valve.shim
      assert @valve_adjustment.min_spec?(@out_of_spec_valve), "Valve should have gap #{@out_of_spec_valve.gap} that is within intake spec"

      assert_equal 5, @engine.shims.count, 'started with 4 shims, and added a new one for adjustment'
    end
  end
end
