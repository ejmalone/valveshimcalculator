# frozen_string_literal: true

FactoryBot.define do
  # --------------------------------------------------------------
  factory :intake_valve, class: 'Valve' do
    gap { 0.2 }
    intake_or_exhaust { Valve::INTAKE }
    valve_num { 1 }
    association :shim

    factory :exhaust_valve do
      gap { 0.25 }
      intake_or_exhaust { Valve::EXHAUST }
    end

    # --------------------------------------------------------------
    factory :out_of_spec_intake_valve do
      gap { 0.05 }
    end
  end
end
