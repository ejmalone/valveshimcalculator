class CreateShims < ActiveRecord::Migration[7.0]
  def change
    create_table :shims do |t|
      t.references :valve, null: false, foreign_key: true
      t.integer :size_mm, unsigned: true

      t.timestamps
    end
  end
end
