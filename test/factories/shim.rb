# frozen_string_literal: true

FactoryBot.define do
  factory :shim do
    thickness { 170 }
    # NOTE: not setting engine here since build needs to follow order, example: klr_with_out_of_spec_valve
  end
end
