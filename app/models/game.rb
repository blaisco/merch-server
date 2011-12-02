# == Schema Information
#
# Table name: games
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  release_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

class Game < ActiveRecord::Base
  has_many    :game_developers, :dependent => :destroy
  has_many    :game_platforms, :dependent => :destroy
  has_many    :game_genres, :dependent => :destroy
  has_many    :developers, :through => :game_developers
  has_many    :platforms, :through => :game_platforms
  has_many    :genres, :through => :game_genres
  belongs_to  :franchise
  
  attr_accessible :fid, :name, :slug, :release_date
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  # def franchise_name=(value)
  #   self.franchise = Franchise.find_or_initialize_by_name(value)
  # end
  
  # def franchise_name
  #   self.franchise.name if self.franchise
  # end
end
