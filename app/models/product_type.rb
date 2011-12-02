# == Schema Information
#
# Table name: product_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  rank       :decimal(3, 1)
#  created_at :datetime
#  updated_at :datetime
#  ancestry   :string(255)
#
# Indexes
#
#  index_product_types_on_ancestry  (ancestry)
#  index_product_types_on_slug      (slug) UNIQUE
#

class ProductType < ActiveRecord::Base
  has_ancestry
  
  attr_accessible :name, :slug, :rank, :parent_id
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
    
  # default_scope :order => 'rank ASC'
end
