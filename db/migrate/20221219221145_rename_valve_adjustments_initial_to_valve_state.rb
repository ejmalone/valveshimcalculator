class RenameValveAdjustmentsInitialToValveState < ActiveRecord::Migration[7.0]
  def change
    rename_column :valve_adjustments, :initial, :valve_state
  end
end
