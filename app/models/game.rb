# == Schema Information
#
# Table name: games
#
#  id           :integer         not null, primary key
#  franchise_id :integer
#  name         :string(255)
#  slug         :string(255)
#  aliases      :string(255)
#  release_date :date
#  fid          :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_games_on_fid   (fid) UNIQUE
#  index_games_on_slug  (slug) UNIQUE
#

class Game < ActiveRecord::Base
  has_many    :game_developers, :dependent => :destroy
  has_many    :game_platforms, :dependent => :destroy
  has_many    :game_genres, :dependent => :destroy
  has_many    :developers, :through => :game_developers
  has_many    :platforms, :through => :game_platforms
  has_many    :genres, :through => :game_genres
  belongs_to  :franchise
  has_many    :products, :as => :merchandisable
  
  attr_accessible :fid, :name, :slug, :release_date
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  def franchise_name=(value)
    self.franchise = Franchise.find_or_initialize_by_name(value)
  end
  
  def franchise_name
    self.franchise.name if self.franchise
  end
  
  def self.create_or_update_from_hash(g)
    game = Game.find_or_initialize_by_fid(g["id"])
    game.name = g["name"]
    game.release_date = g["original_release_date"] unless g["original_release_date"].blank?
    game.aliases = g["aliases"] unless g["aliases"].blank?
    game.save
    
    self.c_or_u_categories_from_hash(game, "Developer", g["developers"])
    self.c_or_u_categories_from_hash(game, "Platform", g["platforms"])
    self.c_or_u_categories_from_hash(game, "Genre", g["genres"]) 
    
    game
  end
  
  private
  
  # Create or update categories (developers, genres, or platforms) for a game
  # TODO: This will add categories to games, but never remove them
  def self.c_or_u_categories_from_hash(game, class_name, hash_for_category)
    hash_for_category.each do |c|
      cat = Kernel.const_get(class_name).find_by_fid(c["id"])
      unless cat
        cat = Kernel.const_get(class_name).new
        cat.name = c["name"]
        cat.fid = c["id"]
        cat.save
      end
      cat.games << game unless cat.games.include?(game)
      cat.save
    end
    game
  end
end
