class AddUserableToEngines < ActiveRecord::Migration[7.0]
  def change
    add_column :engines, :userable_type, :string
    add_column :engines, :userable_id, :integer
  end
end
