class RenameNameToNicknameOnEngine < ActiveRecord::Migration[7.0]
  def change
    rename_column :engines, :name, :nickname
  end
end
