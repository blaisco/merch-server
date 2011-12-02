class CreateGamePlatforms < ActiveRecord::Migration
  def change
    create_table :game_platforms do |t|
      t.references :game
      t.references :platform

      t.timestamps
    end
    add_index :game_platforms, :game_id
    add_index :game_platforms, :platform_id
  end
end
