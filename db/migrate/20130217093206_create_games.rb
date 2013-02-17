class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game_session
      
      t.timestamps
    end
  end
end
