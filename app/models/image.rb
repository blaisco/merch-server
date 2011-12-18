# == Schema Information
#
# Table name: images
#
#  id           :integer         not null, primary key
#  product_id   :integer
#  size         :string(255)
#  original_url :string(255)
#  path         :string(255)
#  hash         :string(40)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_images_on_product_id  (product_id)
#

class Image < ActiveRecord::Base
  belongs_to :product
  
  attr_accessible :url, :url_75px, :url_160px, :url_500px
end
