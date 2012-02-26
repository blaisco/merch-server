require 'digest/sha1'

class ProductJob
  IMAGES_STORE = '/tmp/scrapy/images/'
  # @queue = :products
  
  #~ "{
    #~ \"merchant_url\": \"http://store.valvesoftware.com/\", 
    #~ \"name\": \"Portal 2 Collectors Edition Guide\", 
    #~ \"url\": \"http://store.valvesoftware.com/product.php?i=P0909\", 
    #~ \"image_urls\": [
      #~ \"http://www.example.com/main_images/P0909main.png\"
    #~ ], 
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
    if product.status != Product::STATUSES[:denied] # active, stale, or pending products
      checksum = Digest::SHA1.hexdigest(object.to_s)
      if product.checksum.nil? or product.checksum != checksum # new product or product changed
        product.checksum = checksum
        product.checksum_changed_at = Time.now
        product = create_product(product, object)
        product = create_inventory(product, object["inventory"])
        product = create_images(product, object["images"])
      end
      # Mark as updated even if no changes; I want to know when a product is
      # stale (i.e. no one is trying to update it).
      product.updated_at = Time.now
      product.create_by_api = true
      # Logging failed validations since we don't see them in the server logs
      unless product.save
        logfile = File.new('log/api.log', 'a')    
        audit_log = AuditLogger.new(logfile)
        audit_log.error object.to_s + " | " + product.errors.full_messages.join(", ") 
      end
      product
    end
  end
  
  private
  
  def self.create_product(product, object)
    product.name = object["name"]
    product.description = object["description"]
    product.merchant = Merchant.find_or_initialize_by_url(
      :url => object["merchant_url"], :name => object["merchant_url"]
    )
    product
  end
  
  def self.create_inventory(product, object)
    # Kind of a hack. Rather than check each variation for changes, we just 
    # delete and recreate all of them.
    product.variations.destroy_all unless product.new_record?
    
    object.each do |inv|
      var = product.variations.build
      var.size = inv['size']
      var.color = inv['color']
      var.in_stock = inv['in_stock']
      if var.in_stock
        fig = var.build_figure
        fig.currency = inv['currency']
        fig.price_in_cents = inv['price'].to_i
        fig.amount_saved_in_cents = inv['amount_saved'].to_i
      end
    end
    
    product
  end
  
  def self.create_images(product, object)
    existing = product.images.collect(&:checksum)
    
    object.each do |img|
      # already have the image included; do nothing
      if existing.include? img["checksum"]
        existing.delete img["checksum"]
      else # add image to product
        image = product.images.new
        image.checksum = img["checksum"]
        image.original_url = img["url"]
        
        # We should always be able to find the image, but just in case I don't
        # want an exception to stop us from saving the product.
        path = IMAGES_STORE + img["path"]
        if File.exists? path
          image.data = File.new(path,'r')
        else
          puts "Unable to find image at " + path
        end
      end
    end
    
    # Delete images attached to product that weren't passed in in object
    existing.each do |checksum|
      image = Image.find_by_checksum(checksum)
      image.destroy
    end
    
    product
  end
end
