class CreateGameDevelopers < ActiveRecord::Migration
  def change
    create_table :game_developers do |t|
      t.references :game
      t.references :developer

      t.timestamps
    end
    add_index :game_developers, :game_id
    add_index :game_developers, :developer_id
  end
end
