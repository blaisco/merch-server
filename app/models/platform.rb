# == Schema Information
#
# Table name: platforms
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Platform < ActiveRecord::Base
  has_many :game_platforms, :dependent => :destroy
  has_many :games, :through => :game_platforms

  attr_accessible :name, :slug
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
