# frozen_string_literal: true

# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :bigint           not null, primary key
#  adjustment_date :date
#  mileage         :integer
#  notes           :text
#  status          :string
#  valve_state     :json
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  engine_id       :bigint           not null
#
# Indexes
#
#  index_valve_adjustments_on_engine_id  (engine_id)
#
# Foreign Keys
#
#  fk_rails_...  (engine_id => engines.id)
#
FactoryBot.define do
  factory :valve_adjustment do
    engine { klr_with_out_of_spec_valve }
    mileage { 1_000 }
    adjustment_date { Time.zone.now }
    notes { 'MyText' }
  end
end
