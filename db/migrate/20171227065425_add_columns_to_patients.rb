class AddColumnsToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :classification, :string
    add_column :patients, :distance_to_unknown, :integer
  end
end
