# == Schema Information
#
# Table name: game_franchises
#
#  id           :integer         not null, primary key
#  game_id      :integer
#  franchise_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_game_franchises_on_franchise_id  (franchise_id)
#  index_game_franchises_on_game_id       (game_id)
#

class GameFranchise < ActiveRecord::Base
  belongs_to :game
  belongs_to :franchise
  
  attr_accessible :game_id, :franchise_id
end
