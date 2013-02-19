class AddPlayedByAndBeatedByColumnsToGameLogs < ActiveRecord::Migration
  
  def up
    #in case cardholder=table this will tell who (whether player or computer) had put the card
    add_column "game_logs", "played_by", :integer
    #marks the card played by opponent to beat current on the table
    add_column "game_logs", "beated_with", :integer
  end
  
  def down
    remove_column "game_logs", "played_by"
    remove_column "game_logs", "beated_with"
  end
  
end
