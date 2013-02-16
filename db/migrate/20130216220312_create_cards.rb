class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :rank
      t.string :suite
      t.string :image

      t.timestamps
    end
  end
end
