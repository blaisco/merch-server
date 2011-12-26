class CreateGameFranchises < ActiveRecord::Migration
  def change
    create_table :game_franchises do |t|
      t.references :game
      t.references :franchise

      t.timestamps
    end
    add_index :game_franchises, :game_id
    add_index :game_franchises, :franchise_id
  end
end
