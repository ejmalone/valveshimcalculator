class AddUserIdToAnonymousUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :anonymous_users, :user, null: true, foreign_key: true
  end
end
