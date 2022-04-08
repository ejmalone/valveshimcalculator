class ChangeCompletedToStatusOnValveAdjustments < ActiveRecord::Migration[7.0]
  def up
    remove_column :valve_adjustments, :completed
    add_column :valve_adjustments, :status, :string
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
