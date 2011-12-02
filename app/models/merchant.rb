# == Schema Information
#
# Table name: merchants
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Merchant < ActiveRecord::Base
  has_many :variations
  has_many :offers
  
  attr_accessible :name, :slug, :url
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end
