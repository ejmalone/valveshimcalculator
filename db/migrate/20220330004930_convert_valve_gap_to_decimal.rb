class ConvertValveGapToDecimal < ActiveRecord::Migration[7.0]
  def up
    change_column :valves, :gap, :decimal, precision: 4, scale: 2
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
