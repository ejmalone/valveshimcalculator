class Valve < ApplicationRecord
  belongs_to :cylinder
  has_one :shim, dependent: :destroy

  INTAKE = "intake".freeze
  EXHAUST = "exhaust".freeze
end
