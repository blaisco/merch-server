# == Schema Information
#
# Table name: platforms
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
#  index_platforms_on_fid   (fid) UNIQUE
#  index_platforms_on_slug  (slug) UNIQUE
#

class Platform < ActiveRecord::Base
  has_many :game_platforms, :dependent => :destroy
  has_many :games, :through => :game_platforms

  attr_accessible :name, :slug
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
