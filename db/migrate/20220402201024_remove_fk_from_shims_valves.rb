class RemoveFkFromShimsValves < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :shims, :valves
    remove_index :shims, name: 'index_shims_on_valve_id'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
