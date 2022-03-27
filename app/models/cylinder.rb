class Cylinder < ApplicationRecord
  belongs_to :engine
  has_many :valves, dependent: :destroy
end
