class Image < ActiveRecord::Base
  belongs_to :product
  
  attr_accessible :url, :url_75px, :url_160px, :url_500px
end
