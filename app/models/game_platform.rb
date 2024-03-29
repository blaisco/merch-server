# == Schema Information
#
# Table name: game_platforms
#
#  id          :integer         not null, primary key
#  game_id     :integer
#  platform_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_game_platforms_on_game_id      (game_id)
#  index_game_platforms_on_platform_id  (platform_id)
#

class GamePlatform < ActiveRecord::Base
  belongs_to :game
  belongs_to :platform
  
  attr_accessible :game_id, :platform_id
end
