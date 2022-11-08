class AddInitialAndResultToValveAdjustments < ActiveRecord::Migration[7.0]
  def change
    add_column :valve_adjustments, :initial, :json
    add_column :valve_adjustments, :result, :json
  end
end
