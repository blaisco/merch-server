# == Schema Information
#
# Table name: developers
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
#  index_developers_on_fid   (fid) UNIQUE
#  index_developers_on_slug  (slug) UNIQUE
#

class Developer < ActiveRecord::Base
  has_many :game_developers, :dependent => :destroy
  has_many :games, :through => :game_developers
  
  attr_accessible :fid, :name, :slug
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
