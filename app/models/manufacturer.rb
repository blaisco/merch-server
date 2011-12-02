class Manufacturer < ActiveRecord::Base
  belongs_to :product
  
  attr_accessible :name, :slug
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
