class AddTokenUniqueIndexToAnonymousUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :anonymous_users, :token, unique: true
  end
end
