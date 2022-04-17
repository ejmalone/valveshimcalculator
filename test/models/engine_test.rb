# frozen_string_literal: true

# == Schema Information
#
# Table name: engines
#
#  id                  :bigint           not null, primary key
#  exhaust_max         :decimal(4, 2)
#  exhaust_min         :decimal(4, 2)
#  intake_max          :decimal(4, 2)
#  intake_min          :decimal(4, 2)
#  name                :string
#  num_cylinders       :integer
#  userable_type       :string
#  valves_per_cylinder :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  userable_id         :integer
#
# Indexes
#
#  index_engines_on_userable_type_and_userable_id  (userable_type,userable_id)
#
require 'test_helper'

class EngineTest < ActiveSupport::TestCase
  # --------------------------------------------------------------
  setup do
    @engine = create(:klr650)
    @engine.save
  end

  # --------------------------------------------------------------
  test 'engine has appropriate number of cylinders' do
    assert_equal @engine.cylinders.count, @engine.num_cylinders
  end

  # --------------------------------------------------------------
  test 'engine has appropriate number of valves' do
    assert_equal @engine.cylinders.map(&:valves).flatten.count, @engine.valves_per_cylinder * @engine.num_cylinders
  end
end
