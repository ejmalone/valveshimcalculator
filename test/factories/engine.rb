# frozen_string_literal: true

OUT_OF_SPEC_DIFFERENCE = 0.05

FactoryBot.define do
  factory :klr650, class: 'Engine' do
    association :userable, factory: :user
    make { 'Kawasaki' }
    model { 'KLR 650' }
    num_cylinders { 1 }
    valves_per_cylinder { 4 }
    intake_min { 0.1 }
    intake_max { 0.2 }
    exhaust_min { 0.15 }
    exhaust_max { 0.25 }
  end
end

# --------------------------------------------------------------
# create an engine with the first intake valve out of spec
def klr_with_out_of_spec_valve
  engine = create(:klr650)
  set_out_of_spec = false

  engine.cylinders.first.valves.each do |valve|
    gap = if valve.intake? && !set_out_of_spec
            set_out_of_spec = true
            engine.intake_min - OUT_OF_SPEC_DIFFERENCE
          elsif valve.intake?
            engine.intake_min
          else
            engine.exhaust_min
          end

    valve.update!(gap: gap)
    Shim.create(engine: engine, valve: valve, thickness: (Shim::SIZE_LIMITS.first..Shim::SIZE_LIMITS.last - 100).to_a.sample)
  end

  engine.reload
  engine
end
