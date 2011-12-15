class ProductJob
  @queue = :products

  def self.perform(object)
    product = Product.find_or_initialize_by_url(object["url"])
    unless product.status == 'inactive'
      product.name = object["name"]
      product.summary = object["summary"]
      product.description = object["description"]
      # Mark as updated even if no changes; I want to know when a product is
      # stale (i.e. no one is trying to update it).
      product.updated_at = Time.now
      product.save
    end
  end
end
