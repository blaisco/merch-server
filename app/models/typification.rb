# == Schema Information
#
# Table name: typifications
#
#  id              :integer         not null, primary key
#  product_id      :integer
#  product_type_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_typifications_on_product_id       (product_id)
#  index_typifications_on_product_type_id  (product_type_id)
#

class Typification < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_type
  
  attr_accessible :product_type_id
end
