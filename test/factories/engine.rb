# frozen_string_literal: true

FactoryBot.define do
  factory :klr650, class: 'Engine' do
    association :user
    name { 'KLR 650' }
    num_cylinders { 1 }
    valves_per_cylinder { 4 }
    intake_min { 0.1 }
    intake_max { 0.2 }
    exhaust_min { 0.15 }
    exhaust_max { 0.25 }

    # --------------------------------------------------------------
    factory :klr_without_internals do
      before(:build) { |engine| engine.class.skip_callback(:create, :after, :create_internals) }
    end
  end
end

# --------------------------------------------------------------
# create an engine with the first valve out of spec
def klr_with_out_of_spec_valve
  engine = build(:klr_without_internals)
  engine.cylinders = [build(:cylinder)]
  engine.cylinders[0].valves = [
    build(:out_of_spec_intake_valve, shim: build(:shim, engine: engine)),
    build(:intake_valve, valve_num: 2, shim: build(:shim, engine: engine)),
    build(:exhaust_valve, valve_num: 3, shim: build(:shim, engine: engine)),
    build(:exhaust_valve, valve_num: 4, shim: build(:shim, engine: engine))
  ]

  engine.save!
  engine
end
