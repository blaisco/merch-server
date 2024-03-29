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
  STATUSES = { 
    :approved => 1, # product displayed to users
    :pending => 2,  # new product; needs review
    :denied => 3,   # product not displayed (ignored)
    :stale => 4,    # product hasn't seen updates in 1+ week
  }
  
  STATUSES.each do |status, value|
    scope status, where(:status => value)
  end
  
  # Use 'unscoped' (before any other sql methods) to override
  #default_scope where(:status => STATUSES[:approved])

  #belongs_to :merchandisable, :polymorphic => true
  belongs_to :game
  belongs_to :developer
  belongs_to :franchise
  
  has_many :typifications
  has_many :product_types, :through => :typifications, :dependent => :destroy
  belongs_to :merchant
  has_many :variations, :dependent => :destroy
  has_many :figures, :through => :variations
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :typifications, :allow_destroy => true, :reject_if => proc { |attributes| attributes['product_type_id'].blank? }
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  validates_inclusion_of :status, :in => STATUSES.values,
            :message => "must be in #{STATUSES.keys * ', '}"
  validates :merchandisable_string, :presence => true, :unless => :create_by_api
  validates :typifications, :presence => true, :unless => :create_by_api
            
  before_validation :set_pending_status
  before_save :set_merchandisable
  
  attr_accessor :merchandisable_string, :create_by_api
  attr_accessible :merchant_id, :merchandisable_string, :status, :typifications_attributes
  
  define_index do
    indexes :name, :sortable => true
    indexes :description
    
    #~ indexes game(:name), :as => :game, :facet => true
    #~ indexes franchise(:name), :as => :franchise, :facet => true
    #~ indexes developer(:name), :as => :developer, :facet => true
    #~ indexes merchant(:name), :as => :merchant, :facet => true
    #~ indexes product_types(:name), :as => :product_type, :facet => true
    
    has :status, :updated_at
    has game(:id), :as => :game, :facet => true
    has franchise(:id), :as => :franchise, :facet => true
    has developer(:id), :as => :developer, :facet => true
    has merchant(:id), :as => :merchant, :facet => true
    has product_types(:id), :as => :product_type, :facet => true
  end
  
  #~ # This filters things down to match our :approved scope above
  #~ sphinx_scope(:sphinx_approved) { 
    #~ {:with => {:status => STATUSES[:approved]}}
  #~ }
  #~ default_sphinx_scope :sphinx_approved

  # Return the first image, or a default image
  def primary_image
    @primary_image ||= images.first || Image.new
  end

  def price_range?
    min_figure.price_in_cents != max_figure.price_in_cents
  end
  
  def min_figure
    @min_figure ||= figures.first
  end
  
  def max_figure
    @max_figure ||= figures.last 
  end
  
  def merchandisable
    @merchandisable ||= game || franchise || developer
  end
  
  # avoid doing some callbacks if we're creating/updating a product by api
  def create_by_api
    @create_by_api ||= false
  end
  
  private
  
  def set_pending_status
    self.status ||= STATUSES[:pending]
  end
  
  def set_merchandisable
    unless merchandisable_string.blank?
      self.game = nil
      self.franchise = nil
      self.developer = nil
      
      model, id = merchandisable_string.split('-')
      self.send(model.downcase + "_id=", id)
    end
  end
end
