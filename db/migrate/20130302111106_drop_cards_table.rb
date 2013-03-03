class DropCardsTable < ActiveRecord::Migration
  
  def up
    drop_table :cards
  end

  def down
    create_table :cards do |t|
      t.string :rank
      t.string :suit
      t.string :image
      t.integer :rank_number
      t.string :suit_char
      t.timestamps
    end
  end
  
end
