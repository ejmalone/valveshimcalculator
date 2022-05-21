# == Schema Information
#
# Table name: adders
#
#  id         :bigint           not null, primary key
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Adder < ApplicationRecord
end
