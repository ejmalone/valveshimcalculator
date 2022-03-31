# frozen_string_literal: true

# == Schema Information
#
# Table name: shims
#
#  id         :bigint           not null, primary key
#  size_mm    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  valve_id   :integer          not null
#
# Indexes
#
#  index_shims_on_valve_id  (valve_id)
#
# Foreign Keys
#
#  fk_rails_...  (valve_id => valves.id)
#
require 'test_helper'

class ShimTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
