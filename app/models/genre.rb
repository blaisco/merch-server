# == Schema Information
#
# Table name: genres
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  fid        :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_genres_on_fid   (fid) UNIQUE
#  index_genres_on_slug  (slug) UNIQUE
#

class Genre < ActiveRecord::Base
  has_many :game_genres, :dependent => :destroy
  has_many :games, :through => :game_genres

  attr_accessible :name, :slug
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
