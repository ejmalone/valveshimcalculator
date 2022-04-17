class AddUserableIndexToEngines < ActiveRecord::Migration[7.0]
  def change
    add_index :engines, [ :userable_type, :userable_id ]
  end
end
