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
end
