# == Schema Information
#
# Table name: anonymous_users
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class AnonymousUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
