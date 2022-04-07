class AddCompletedToValveAdjustments < ActiveRecord::Migration[7.0]
  def change
    add_column :valve_adjustments, :completed, :boolean
  end
end
