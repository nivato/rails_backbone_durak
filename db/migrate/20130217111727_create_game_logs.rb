class CreateGameLogs < ActiveRecord::Migration
  
  def up
    create_table :game_logs do |t|
      t.references :game
      t.references :cardholder
      t.references :card
      t.timestamps
    end
    add_index :game_logs, ["game_id", "cardholder_id", "card_id"]
  end
  
  def down
    drop_table :game_logs
  end
  
end
