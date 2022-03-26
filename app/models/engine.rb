class Engine < ApplicationRecord
  belongs_to :user
  has_many :shims, dependent: :destroy
end