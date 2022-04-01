class RenameShimSizeMmToThickness < ActiveRecord::Migration[7.0]
  def up
    rename_column :shims, :size_mm, :thickness
  end

  def down
    rename_column :shims, :thickness, :size_mm
  end
end
