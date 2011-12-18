require 'digest/sha1'

class ProductJob
  @queue = :products
  
  #~ "{
    #~ \"name\": \"Portal 2 Collectors Edition Guide\", 
    #~ \"url\": \"http://store.valvesoftware.com/product.php?i=P0909\", 
    #~ \"image_urls\": [
      #~ \"http://www.example.com/main_images/P0909main.png\"
    #~ ], 
    #~ \"summary\": \"This strictly limited collector\\u0092s [snip].\", 
    #~ \"inventory\": [
      #~ {
        #~ \"amount_saved\": \"500\", 
        #~ \"color\": null, 
        #~ \"currency\": \"USD\",
        #~ \"in_stock\": true, 
        #~ \"price\": \"2499\", 
        #~ \"size\": null
      #~ }
    #~ ],
    #~ \"images\": [
      #~ {
        #~ \"url\": \"http://www.example.com/main_images/P0909main.png\", 
        #~ \"path\": \"full/e7082274593a43382d1d1424ec4ea9b540569e06.jpg\", 
        #~ \"checksum\": \"f3b00dc98d85a335be4aa95a41d37520\"
      #~ }
    #~ ],
    #~ \"description\": \"This strictly limited collector\\u0092s [snip]"\"
  #~ }"


  def self.perform(object)
    product = Product.find_or_initialize_by_url(object["url"])
    if product.status != 'inactive' # active or pending products
      hash = Digest::SHA1.hexdigest(object.to_s)
      if product.hash.nil? or product.hash != hash # new product or product changed
        product.hash = hash
        product.hash_changed_at = Time.now
        product = create_product(product, object)
        product = create_inventory(product, object["inventory"])
        product = create_images(product, object["images"])
      end
      product.updated_at = Time.now
      product.save
    end
  end
  
  def self.create_product(product, object)
    product.name = object["name"]
    product.summary = object["summary"]
    product.description = object["description"]
    # Mark as updated even if no changes; I want to know when a product is
    # stale (i.e. no one is trying to update it).
    product
  end
  
  def self.create_inventory(product, object)
    object.each do |inv|
 
    end
    product
  end
  
  def self.create_images(product, object)
    unless object.nil? # might not have images for a product
      object.each do |img|
        
      end
    end
    product
  end
end
