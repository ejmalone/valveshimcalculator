class CreateEngines < ActiveRecord::Migration[7.0]
  def change
    create_table :engines do |t|
      t.integer :user_id
      t.integer :cylinders
      t.integer :valves_per_cylinder
      t.string :name

      t.timestamps
    end
  end
end
