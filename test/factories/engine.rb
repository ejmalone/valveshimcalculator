FactoryBot.define do
  factory :klr650, class: "Engine" do
    user { create(:user) }
    num_cylinders { 1 }
    valves_per_cylinder { 4 }
    intake_min { 0.1 }
    intake_max { 0.2 }
    exhaust_min { 0.15 }
    exhaust_max { 0.25 }
  end
end