# == Schema Information
#
# Table name: franchises
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_franchises_on_slug  (slug) UNIQUE
#

class Franchise < ActiveRecord::Base
  has_many :games
  has_many :products, :as => :merchandisable
  
  attr_accessible :name, :slug

  extend FriendlyId
  friendly_id :name, :use => :slugged
end
