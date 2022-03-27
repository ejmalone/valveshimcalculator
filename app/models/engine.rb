class Engine < ApplicationRecord
  belongs_to :user
  has_many :cylinders, dependent: :destroy

  after_create :create_internals

  private

  def create_internals
    num_cylinders.times do |cyl_index|
      cylinders << Cylinder.create(cylinder_num: cyl_index + 1) do |cylinder|
        valve_num = 0
        (valves_per_cylinder / 2).times do
          cylinder.valves << Valve.create(intake_or_exhaust: Valve::INTAKE, valve_num: (valve_num += 1))
          cylinder.valves << Valve.create(intake_or_exhaust: Valve::EXHAUST, valve_num: (valve_num += 1))
        end
      end
    end
  end
end