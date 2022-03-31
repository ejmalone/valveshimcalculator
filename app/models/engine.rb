# == Schema Information
#
# Table name: engines
#
#  id                  :bigint           not null, primary key
#  exhaust_max         :decimal(4, 2)
#  exhaust_min         :decimal(4, 2)
#  intake_max          :decimal(4, 2)
#  intake_min          :decimal(4, 2)
#  name                :string
#  num_cylinders       :integer
#  valves_per_cylinder :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer          not null
#
# Indexes
#
#  index_engines_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Engine < ApplicationRecord
  CYLINDER_OPTS = [ 1, 2, 4 ].freeze
  VALVES_PER_CYLINDER_OPTS = [ 2, 4 ].freeze

  belongs_to :user
  has_many :cylinders, dependent: :destroy
  has_many :valve_adjustments, dependent: :destroy

  after_create :create_internals

  validates :num_cylinders, inclusion: CYLINDER_OPTS
  validates :valves_per_cylinder, inclusion: VALVES_PER_CYLINDER_OPTS
  validate :valve_clearances_are_valid
  validates :name, presence: true

  scope :includes_shims, -> { includes(cylinders: { valves: :shim }) }

  # --------------------------------------------------------------
  # Determines if an engine needs initial setup for shims
  def lacks_shims?
    Engine.where(id: id).includes_shims.pluck("shims.id").all?(&:blank?)
  end

  # --------------------------------------------------------------
  private
  # --------------------------------------------------------------

  # --------------------------------------------------------------
  def create_internals
    num_cylinders.times do |cyl_index|
      cylinders << Cylinder.create(cylinder_num: cyl_index + 1) do |cylinder|
        valves_per_cylinder.times do |i|
          cylinder.valves << Valve.create(
            intake_or_exhaust: i < valves_per_cylinder / 2 ? Valve::INTAKE : Valve::EXHAUST,
            valve_num: i + 1
          )
        end
      end
    end
  end

  # --------------------------------------------------------------
  def valve_clearances_are_valid
    clearances = [
      %w[ intake_min intake_max ],
      %w[ exhaust_min exhaust_max ]
    ]

    clearances.flatten.each do |clearance|
      errors.add(clearance, "can't be less than zero") if send(clearance) <= 0.0
    end

    clearances.each do |(min,max)|
      errors.add(:base, "#{ min.humanize } and #{ max.humanize } is an invalid range") if send(min) >= send(max)
    end
  end
end
