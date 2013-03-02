class DropGameLogsTable < ActiveRecord::Migration
  
  def up
    drop_table "game_logs"
  end

  def down
    create_table "game_logs" do |t|
      t.references :game
      t.references :cardholder
      t.references :card
      t.timestamps
      t.integer  "position"
      t.integer  "played_by"
    end
  end
  
end
