class CreateShims < ActiveRecord::Migration[7.0]
  def change
    create_table :shims do |t|
      t.references :engine, null: false, foreign_key: true
      t.integer :size_mm, unsigned: true
      t.boolean :in_use
      t.integer :cylinder, unsigned: true
      t.string :valve
      t.integer :valve_num, unsigned: true

      t.timestamps
    end
  end
end
