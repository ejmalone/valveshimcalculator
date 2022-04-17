# == Schema Information
#
# Table name: anonymous_users
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :anonymous_user do
    token { "MyString" }
  end
end
