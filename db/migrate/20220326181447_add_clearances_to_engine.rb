class AddClearancesToEngine < ActiveRecord::Migration[7.0]
  def change
    add_column :engines, :intake_min,  :decimal, precision: 4, scale: 2
    add_column :engines, :intake_max,  :decimal, precision: 4, scale: 2
    add_column :engines, :exhaust_min, :decimal, precision: 4, scale: 2
    add_column :engines, :exhaust_max, :decimal, precision: 4, scale: 2
  end
end
