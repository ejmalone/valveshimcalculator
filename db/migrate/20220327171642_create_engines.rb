class CreateEngines < ActiveRecord::Migration[7.0]
  def change
    create_table :engines do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :cylinders
      t.integer :valves_per_cylinder
      t.string :name
      t.decimal :intake_min, precision: 4, scale: 2
      t.decimal :intake_max, precision: 4, scale: 2
      t.decimal :exhaust_min, precision: 4, scale: 2
      t.decimal :exhaust_max, precision: 4, scale: 2

      t.timestamps
    end
  end
end
