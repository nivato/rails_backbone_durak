class AddPositionColumnToGameLogs < ActiveRecord::Migration
  
  def up
    add_column "game_logs", "position", :integer
  end
  
  def down
    remove_column "game_logs", "position"
  end
  
end
