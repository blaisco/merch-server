# == Schema Information
#
# Table name: products
#
#  id                  :integer         not null, primary key
#  merchandisable_id   :integer
#  merchandisable_type :string(255)
#  product_type_id     :integer
#  merchant_id         :integer
#  slug                :string(255)
#  name                :string(255)
#  url                 :string(255)
#  summary             :string(255)
#  description         :text
#  status              :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_products_on_merchandisable_type_and_merchandisable_id  (merchandisable_type,merchandisable_id)
#  index_products_on_merchant_id                                (merchant_id)
#  index_products_on_product_type_id                            (product_type_id)
#  index_products_on_slug                                       (slug) UNIQUE
#  index_products_on_status                                     (status)
#

class Product < ActiveRecord::Base
  belongs_to :merchandisable, :polymorphic => true
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
  
  STATUSES = [
    'pending',  # new product; needs review
    'active',   # product displayed to users
    'inactive'  # product not displayed (ignored)
  ]
  validates_inclusion_of :status, :in => STATUSES,
            :message => "{{value}} must be in #{STATUSES.join ','}"
  
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
