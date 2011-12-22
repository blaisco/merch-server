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
  has_many :product_types, :through => :typification, :dependent => :destroy
  belongs_to :merchant
  has_many :variations, :dependent => :destroy
  has_many :images, :dependent => :destroy
  
  serialize :features, Array
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates_inclusion_of :status, :in => STATUSES,
            :message => "{{value}} must be in #{STATUSES.join ','}"
            
  before_validation :set_pending_status
  
  private
  
  def set_pending_status
    self.status ||= 'pending'
  end
end
