class CreateValves < ActiveRecord::Migration[7.0]
  def change
    create_table :valves do |t|
      t.references :cylinder, null: false, foreign_key: true
      t.integer :gap, unsigned: true
      t.string :intake_or_exhaust
      t.integer :cylinder_num, unsigned: true

      t.timestamps
    end
  end
end
