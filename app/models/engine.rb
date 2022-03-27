class Engine < ApplicationRecord
  belongs_to :user
  has_many :cylinders, dependent: :destroy

  after_create :create_internals

  private

  def create_internals
    num_cylinders.times do |cyl_index|
      cylinders << Cylinder.create(cylinder_num: cyl_index + 1)
    end
  end
end