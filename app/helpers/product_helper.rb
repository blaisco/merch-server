module ProductHelper  
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
  
  # Add/remove a record to/from a url.
  # If the record is already in the url, it's removed. Otherwise, it's added.
  def url_builder_multi(record)
    field = record.class.to_s.tableize
    vars = params.dup
    
    if vars.has_key? field
      ids = vars[field].split(',')
      if ids.include? record.id.to_s
        ids.delete record.id.to_s
        vars.delete(field) if ids.empty?
      else
        ids.push record.id.to_s
      end
      vars[field] = ids.join(',') if vars.has_key? field
    else
      vars[field] = record.id.to_s
    end
    
    vars
  end
  
  def params_includes?(record)
    field = record.class.to_s.tableize
    params.has_key?(field) && params[field] == record.id.to_s
  end
  
  # Add/remove a record to/from a url.
  # If the record is already in the url, it's removed. Otherwise, it's added.
  def url_builder_single(record)
    field = record.class.to_s.tableize
    vars = params.dup
    
    if vars.has_key? field
      if vars[field] == record.id.to_s
        vars.delete(field)
      else
        vars[field] = record.id.to_s
      end
    else
      vars[field] = record.id.to_s
    end
    
    vars
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
  
  def related_products(has_products, limit, exclude)
    has_products.products.where("products.id NOT IN (?)", exclude).order("RANDOM()").limit(limit)
  end
end
