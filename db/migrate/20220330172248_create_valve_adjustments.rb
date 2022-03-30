class CreateValveAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :valve_adjustments do |t|
      t.references :engine, null: false, foreign_key: true
      t.integer :mileage, unsigned: true
      t.date :adjustment_date
      t.text :notes

      t.timestamps
    end
  end
end
