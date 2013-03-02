class DropCardholdersTable < ActiveRecord::Migration
  
  def up
    drop_table :cardholders
  end

  def down
    create_table :cardholders do |t|
      t.string   "ch_type"
      t.timestamps
    end
  end
  
end
