# == Schema Information
#
# Table name: cylinders
#
#  id           :bigint           not null, primary key
#  cylinder_num :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  engine_id    :integer          not null
#
# Indexes
#
#  index_cylinders_on_engine_id  (engine_id)
#
# Foreign Keys
#
#  fk_rails_...  (engine_id => engines.id)
#
require 'test_helper'

class CylinderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
