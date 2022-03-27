class RenameCylindersToNumCylindersOnEngine < ActiveRecord::Migration[7.0]
  def change
    rename_column :engines, :cylinders, :num_cylinders
  end
end
