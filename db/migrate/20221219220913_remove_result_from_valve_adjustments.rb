class RemoveResultFromValveAdjustments < ActiveRecord::Migration[7.0]
  def change
    remove_column :valve_adjustments, :result, :json
  end
end
