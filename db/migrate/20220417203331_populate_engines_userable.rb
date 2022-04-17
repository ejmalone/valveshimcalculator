class PopulateEnginesUserable < ActiveRecord::Migration[7.0]
  def up
    Engine.update_all(userable_type: "User")
    Engine.update_all("userable_id = user_id")
  end

  def down
    Engine.update_all(userable_id: nil, userable_type: nil)
  end
end
