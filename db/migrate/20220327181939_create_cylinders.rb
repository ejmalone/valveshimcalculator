class CreateCylinders < ActiveRecord::Migration[7.0]
  def change
    create_table :cylinders do |t|
      t.references :engine, null: false, foreign_key: true
      t.integer :cylinder_num, unsigned: true

      t.timestamps
    end
  end
end
