class AddMakeAndModelToEngine < ActiveRecord::Migration[7.0]
  def change
    add_column :engines, :make, :string
    add_column :engines, :model, :string
  end
end
