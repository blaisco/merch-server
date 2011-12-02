# == Schema Information
#
# Table name: stocks
#
#  id               :integer         not null, primary key
#  style_id         :integer
#  merchant_id      :integer
#  product_page_url :string(255)
#  reviews_url      :string(255)
#  sku              :string(255)
#  quantity         :integer
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_stocks_on_merchant_id  (merchant_id)
#  index_stocks_on_style_id     (style_id)
#

class Offer < ActiveRecord::Base
  belongs_to :variation
  belongs_to :merchant
  has_many :figures
    
  attr_accessible :product_page_url, :reviews_page_url, :quantity
  
  def merchant_name
    merchant.name if merchant
  end
  
  def merchant_name=(name)
    self.merchant = Merchant.find_or_create_by_name(name)
  end
end
