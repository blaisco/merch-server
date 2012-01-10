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
    'active',   # product displayed to users
    'pending',  # new product; needs review
    'inactive'  # product not displayed (ignored)
  ]
  
  scope :active, where("status = ? AND updated_at >= ?", :active, 1.week.ago)
  scope :stale, where("status = ? AND updated_at < ?", :active, 1.week.ago)
  scope :inactive, where(:status => "inactive")
  scope :pending, where(:status => "pending")
  
  # Use 'unscoped' (before any other sql methods) to override
  default_scope where(:status => 'active')

  belongs_to :merchandisable, :polymorphic => true
  has_many :typifications
  has_many :product_types, :through => :typifications, :dependent => :destroy
  belongs_to :merchant
  has_many :variations, :dependent => :destroy
  has_many :figures, :through => :variations
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :typifications, :allow_destroy => true, :reject_if => proc { |attributes| attributes['product_type_id'].blank? }
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates_inclusion_of :status, :in => STATUSES,
            :message => "{{value}} must be in #{STATUSES.join ','}"
  validates :merchandisable_string, :presence => true, :on => :update
  validates :typifications, :presence => true, :on => :update
            
  before_validation :set_pending_status
  before_save :set_merchandisable
  
  attr_accessor :merchandisable_string
  attr_accessible :merchant_id, :merchandisable_string, :status, :typifications_attributes

  # Return the first image, or a default image
  def primary_image
    images.first || Image.new
  end

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
    unless merchandisable_string.blank?
      model, id = merchandisable_string.split('-')
      self.merchandisable = model.constantize.find(id)
    end
  end
end
