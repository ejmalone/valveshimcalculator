class AddEngineIdToShims < ActiveRecord::Migration[7.0]
  def change
    add_reference :shims, :engine, null: true, foreign_key: true
  end
end
