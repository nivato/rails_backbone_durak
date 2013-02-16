class CreateCardholders < ActiveRecord::Migration
  def change
    create_table :cardholders do |t|
      t.string :type

      t.timestamps
    end
  end
end
