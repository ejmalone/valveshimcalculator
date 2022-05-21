class CreateAdders < ActiveRecord::Migration[7.0]
  def change
    create_table :adders do |t|
      t.integer :value

      t.timestamps
    end
  end
end
