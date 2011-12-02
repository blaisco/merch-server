# == Schema Information
#
# Table name: styles
#
#  id         :integer         not null, primary key
#  product_id :integer
#  name       :string(255)
#  upc        :string(255)
#  ean        :string(255)
#  isbn       :string(255)
#  mpn        :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_styles_on_product_id  (product_id)
#

class Variation < ActiveRecord::Base
  belongs_to :product
  has_many :offers

  attr_accessible :name, :upc, :ean, :isbn, :mpn
end
