class AlterValveIdAndAddIndexToShims < ActiveRecord::Migration[7.0]
  def up
    change_column :shims, :valve_id, :integer, null: true
    add_index :shims, :valve_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
