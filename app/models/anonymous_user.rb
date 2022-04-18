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
class AnonymousUser < ApplicationRecord
  has_many :engines, as: :userable, dependent: :destroy
  belongs_to :user, optional: true

  before_create :set_token

  # --------------------------------------------------------------
  private

  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def set_token
    self.token = Devise.friendly_token
  end
end
