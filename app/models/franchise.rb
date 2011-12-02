class Franchise < ActiveRecord::Base
  has_many :games
  has_many :products
  
  attr_accessible :name, :slug

  extend FriendlyId
  friendly_id :name, :use => :slugged
end
