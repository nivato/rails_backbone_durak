class RemoveBeatedWithColumnFromGameLogs < ActiveRecord::Migration
  
  def up
    # There is no need in thise column since maping between attacker's card
    # and defender's one is handled by positioning
    remove_column "game_logs", "beated_with"
  end

  def down
    add_column "game_logs", "beated_with", :integer
  end
  
end
