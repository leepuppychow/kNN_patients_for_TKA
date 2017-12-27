class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.integer :age
      t.integer :pain_level
      t.float :bodyweight
      t.integer :knee_AROM

      t.timestamps 
    end
  end
end
