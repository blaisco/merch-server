# == Schema Information
#
# Table name: game_developers
#
#  id           :integer         not null, primary key
#  game_id      :integer
#  developer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_game_developers_on_developer_id  (developer_id)
#  index_game_developers_on_game_id       (game_id)
#

class GameDeveloper < ActiveRecord::Base
  belongs_to :game
  belongs_to :developer
  
  attr_accessible :game_id, :developer_id
end
