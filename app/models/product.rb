# == Schema Information
#
# Table name: products
#
#  id                  :integer         not null, primary key
#  merchandisable_id   :integer
#  merchandisable_type :string(255)
#  merchant_id         :integer
#  slug                :string(255)
#  name                :string(255)
#  url                 :string(255)
#  summary             :string(255)
#  description         :text
#  status              :string(255)
#  checksum            :string(40)
#  checksum_changed_at :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_products_on_checksum                                   (checksum)
#  index_products_on_merchandisable_type_and_merchandisable_id  (merchandisable_type,merchandisable_id)
#  index_products_on_merchant_id                                (merchant_id)
#  index_products_on_slug                                       (slug) UNIQUE
#  index_products_on_status                                     (status)
#

class Product < ActiveRecord::Base
  STATUSES = [
    'pending',  # new product; needs review
    'active',   # product displayed to users
    'inactive'  # product not displayed (ignored)
  ]

  belongs_to :merchandisable, :polymorphic => true
  has_many :typifications
  has_many :product_types, :through => :typifications, :dependent => :destroy
  belongs_to :merchant
  has_many :variations, :dependent => :destroy
  has_many :figures, :through => :variations
  has_many :images, :dependent => :destroy
  
  serialize :features, Array
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates_inclusion_of :status, :in => STATUSES,
            :message => "{{value}} must be in #{STATUSES.join ','}"
            
  before_validation :set_pending_status
  before_save :set_merchandisable
  
  attr_accessor :merchandisable_string
  attr_accessible :merchant_id, :merchandisable_string

  def price_range?
    min_figure.price_in_cents != max_figure.price_in_cents
  end
  
  def min_figure
    @min_figure ||= figures.order('price_in_cents ASC').first
  end
  
  def max_figure
    @max_figure ||= figures.order('price_in_cents DESC').first 
  end
  
  private
  
  def set_pending_status
    self.status ||= 'pending'
  end
  
  def set_merchandisable
    if merchandisable_string
      model, id = merchandisable_string.split('-')
      self.merchandisable = model.constantize.find(id)
    end
  end
end
