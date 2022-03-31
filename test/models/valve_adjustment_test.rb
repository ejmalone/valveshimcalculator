# frozen_string_literal: true

# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :bigint           not null, primary key
#  adjustment_date :date
#  mileage         :integer
#  notes           :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  engine_id       :integer          not null
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
  # test "the truth" do
  #   assert true
  # end
end
