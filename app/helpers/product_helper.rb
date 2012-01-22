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
  def url_builder(record)
    id_field = id_field(record)
    vars = params.dup

    if vars.has_key? id_field
      if vars[id_field].include? record.id.to_s
        vars[id_field].delete record.id.to_s
        vars.delete(id_field) if vars[id_field].empty?
      else
        vars[id_field].push record.id
      end
    else
      vars[id_field] = [record.id]
    end
    
    vars
  end



  private
  
  # Converts a record's class into a param string (e.g. Game to game_id)
  def id_field(record)
    record.class.to_s.downcase + "_id"
  end

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
