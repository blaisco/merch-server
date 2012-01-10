# == Schema Information
#
# Table name: images
#
#  id                :integer         not null, primary key
#  product_id        :integer
#  original_url      :string(255)
#  checksum          :string(40)
#  created_at        :datetime
#  updated_at        :datetime
#  data_file_name    :string(255)
#  data_content_type :string(255)
#  data_file_size    :integer
#  data_updated_at   :datetime
#
# Indexes
#
#  index_images_on_checksum    (checksum)
#  index_images_on_product_id  (product_id)
#

class Image < ActiveRecord::Base
  BASE_PATH = "/images/products/"

  belongs_to :product
  
  has_attached_file :data, 
        :styles => { 
          :medium => "550x>", 
          :small => "170x135>",
          :thumb => "70x70>" },
        :default_url => '/images/missing_:style.jpg'
end
