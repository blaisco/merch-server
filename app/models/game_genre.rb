# == Schema Information
#
# Table name: game_genres
#
#  id         :integer         not null, primary key
#  game_id    :integer
#  genre_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_game_genres_on_game_id   (game_id)
#  index_game_genres_on_genre_id  (genre_id)
#

class GameGenre < ActiveRecord::Base
  belongs_to :game
  belongs_to :genre
  
  attr_accessible :game_id, :genre_id
end
