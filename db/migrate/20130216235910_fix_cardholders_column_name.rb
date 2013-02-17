class FixCardholdersColumnName < ActiveRecord::Migration
  
  def up
    rename_column("cardholders", "type", "ch_type")
  end

  def down
    rename_column("cardholders", "ch_type", "type")
  end
  
end
