# == Schema Information
#
# Table name: genres
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Genre < ActiveRecord::Base
  has_many :game_genres, :dependent => :destroy
  has_many :games, :through => :game_genres

  attr_accessible :name, :slug
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
