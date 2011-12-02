class CreateGameGenres < ActiveRecord::Migration
  def change
    create_table :game_genres do |t|
      t.references :game
      t.references :genre

      t.timestamps
    end
    add_index :game_genres, :game_id
    add_index :game_genres, :genre_id
  end
end
