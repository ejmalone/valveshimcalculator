# == Schema Information
#
# Table name: anonymous_users
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AnonymousUser < ApplicationRecord
  has_many :engines, as: :userable, dependent: :destroy

  before_create :set_token

  # --------------------------------------------------------------
  private
  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def set_token
    self.token = Devise.friendly_token
  end
end
