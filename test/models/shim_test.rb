# frozen_string_literal: true

# == Schema Information
#
# Table name: shims
#
#  id         :bigint           not null, primary key
#  thickness  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  engine_id  :bigint
#  valve_id   :integer
#
# Indexes
#
#  index_shims_on_engine_id  (engine_id)
#  index_shims_on_valve_id   (valve_id)
#
# Foreign Keys
#
#  fk_rails_...  (engine_id => engines.id)
#
require 'test_helper'

class ShimTest < ActiveSupport::TestCase
  # --------------------------------------------------------------
  setup do
    @engine = create(:klr650)
  end

  # --------------------------------------------------------------
  test 'shim created for valve' do
    thickness = 150
    valve = @engine.cylinders.first.valves.sample

    assert_nil valve.shim

    Shim.create_for_engine!(valve, thickness)

    assert_not_nil valve.shim
    assert_equal thickness, valve.shim.thickness
  end

  # --------------------------------------------------------------
  test 'create new shim on engine' do
    shim = Shim.new(engine: @engine, thickness: 100)
    assert shim.save!, 'Shim should be able to create without an associated valve'
  end
end
