class RenameCylinderIdToValveNumOnValves < ActiveRecord::Migration[7.0]
  def change
    rename_column :valves, :cylinder_num, :valve_num
  end
end
