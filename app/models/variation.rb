# == Schema Information
#
# Table name: variations
#
#  id         :integer         not null, primary key
#  product_id :integer
#  size       :string(255)
#  color      :string(255)
#  in_stock   :boolean
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_variations_on_product_id  (product_id)
#

class Variation < ActiveRecord::Base
  belongs_to :product
  has_many :figures

  attr_accessible :name, :upc, :ean, :isbn, :mpn
end
