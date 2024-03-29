# frozen_string_literal: true

# == Schema Information
#
# Table name: anonymous_users
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_anonymous_users_on_token    (token) UNIQUE
#  index_anonymous_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class AnonymousUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
