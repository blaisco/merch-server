module ProductHelper
  def breadcrumb(category)
    html = ""
    category.ancestors.each do |ancestor|
      if ancestor.is_root?
        link = product_types_path
      else
        link = product_type_path(ancestor)
      end
      html << link_to(ancestor.name, link, :class => "nodename") + " > "
    end
    html << link_to(category.name, category, :class => "nodename current")
    html.html_safe
  end
  
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
end
