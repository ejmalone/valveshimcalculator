class RemoveUserIdFromEngines < ActiveRecord::Migration[7.0]
  def change
    remove_column :engines, :user_id, :integer
  end
end
