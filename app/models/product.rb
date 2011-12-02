# == Schema Information
#
# Table name: products
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  description         :text
#  features            :text
#  officially_licensed :boolean
#  manufacturer_id     :integer
#  game_id             :integer
#  product_type_id     :integer
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_products_on_game_id          (game_id)
#  index_products_on_product_type_id  (product_type_id)
#

class Product < ActiveRecord::Base
  belongs_to :game
  belongs_to :franchise
  belongs_to :product_type
  has_many :variations
  has_many :images
  has_one :manufacturer
    
  attr_accessible :name, :slug, :short_desc, :description
  attr_accessible :features, :features_as_text, :game_id, :franchise_id
  attr_accessible :product_type_id
  
  serialize :features, Array
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  def features_as_text()
    text = ""
    features.each do |feature|
      text += feature + "\r\n"
    end
    text.chop
  end
  
  def features_as_text=(text)
    self.features = text.split("\r\n")
  end
end
