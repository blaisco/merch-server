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
  has_many    :game_franchises, :dependent => :destroy
  has_many    :developers, :through => :game_developers
  has_many    :platforms, :through => :game_platforms
  has_many    :genres, :through => :game_genres
  has_many    :franchises, :through => :game_franchises
  belongs_to  :franchise
  has_many    :products, :as => :merchandisable
  
  attr_accessible :fid, :name, :slug, :release_date
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  def self.create_or_update_from_hash(g)
    game = Game.find_or_initialize_by_fid(g["id"])
    game.name = g["name"]
    game.release_date = g["original_release_date"] unless g["original_release_date"].blank?
    game.aliases = g["aliases"] unless g["aliases"].blank?
    
    self.c_or_u_categories_from_hash(game, "Developer", g["developers"])
    self.c_or_u_categories_from_hash(game, "Platform", g["platforms"])
    self.c_or_u_categories_from_hash(game, "Genre", g["genres"]) 
    self.c_or_u_categories_from_hash(game, "Franchise", g["franchises"]) 
    
    game.save
    game
  end
  
  private
    
  # Create or update categories (developers, genres, or platforms) for a game
  # CAUTION: Here be dragons. Lots of rarely used methods in here so that we can
  # create a variety of types of associations using one method.
  # TODO: Make this method suck less.
  def self.c_or_u_categories_from_hash(game, class_name, hash_for_category)
  
    # Get a list of existing assoc's
    # For each category:
    #   Does category exist? If it does:
    #     Does the game have an assoc with the category? If it does:
    #       Remove it from the list of existing assoc's
    #     If it doesn't:
    #        Create an assoc between the category and the game
    #   If it doesn't:
    #     Create the category
    #     Create an assoc between the category and game
    # Delete from our list of remaining assoc's
      
    existing = game.association(class_name.downcase.pluralize.to_sym).find(:all).collect(&:id)

    hash_for_category.each do |c| # Valve, Blizzard
      category = class_name.constantize.find_by_fid(c["id"])
      if category
        if existing.include? category.id
          existing.delete category.id
        else
          # I couldn't find a way to make something similar to 
          # game.association(class_name.downcase.pluralize.to_sym).push cat
          # work (it complained it couldn't find 'push). So I'm doing the below instead.

          # assoc = game.association(:game_developers).build
          assoc = game.association(("game_" + class_name.downcase.pluralize).to_sym).build
          # assoc.send(:developer=, cat)
          assoc.send((class_name.downcase + "=").to_sym, category)
        end
      else
        category = game.association(class_name.downcase.pluralize.to_sym).build
        category.name = c["name"]
        category.fid = c["id"]
      end
    end
    
    existing.each do |class_id|
      assoc = ("Game" + class_name).constantize.where({:game_id => game.id, (class_name.downcase+"_id").to_sym => class_id}).first
      assoc.destroy
    end
    
    game
  end
end
