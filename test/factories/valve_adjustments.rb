# == Schema Information
#
# Table name: valve_adjustments
#
#  id              :bigint           not null, primary key
#  adjustment_date :date
#  mileage         :integer
#  notes           :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  engine_id       :integer          not null
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
    engine { nil }
    mileage { 1 }
    adjustment_date { "2022-03-30" }
    notes { "MyText" }
  end
end
