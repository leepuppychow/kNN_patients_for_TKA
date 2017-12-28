class ChangeDistanceToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :patients, :distance_to_unknown, :float
  end
end
