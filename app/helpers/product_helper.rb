module ProductHelper  
  def price(product)
    if product.price_range?
      product.min_figure.price.format + "-" + product.max_figure.price.format 
            + " " + product.max_figure.currency
    else
      product.max_figure.price.format + " " + product.max_figure.currency
    end
  end
  
  def merchant_options_for_select(selected = nil)
    options_for_select( Merchant.all.map { |merchant| [merchant.name, merchant.id] }, selected )
  end
  
  def merchandisable_grouped_options(merchandisable=nil)
    selected_key = nil
    selected_key = (merchandisable.class.to_s + "-" + merchandisable.id.to_s) if merchandisable
    grouped_options = {
      'Games' => Game.all.map(&merchandisable_option_for_select),
      'Franchises' => Franchise.all.map(&merchandisable_option_for_select),
      'Developers' => Developer.all.map(&merchandisable_option_for_select)
    }

    grouped_options_for_select(grouped_options, selected_key)
  end

  private

  def merchandisable_option_for_select
    lambda {|record| [record.name, "#{record.class.name}-#{record.id}"] }
  end
  
  def status_options_for_select(selected = nil)
    options_for_select( Product::STATUSES.map { |status| [status.capitalize, status] }, selected )
  end
  
  def product_type_grouped_options(product_type=nil)
    root = ProductType.roots.first
    grouped_options = {}
    root.children.all(:order => :rank).each do |parent|
      grouped_options[parent.name] = []
      parent.children.all(:order => :rank).each do |cat|
        grouped_options[parent.name] << [cat.name, cat.id]
      end
    end
    grouped_options_for_select(grouped_options, product_type)
  end
  
  def related_products(has_products, limit, exclude=nil)
    products = has_products.products
    products = products.where("products.id NOT IN (?)", exclude) if exclude
    products = products.order("RANDOM()").limit(limit)
  end
end
