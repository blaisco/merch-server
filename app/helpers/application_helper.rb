module ApplicationHelper
  def breadcrumb(category)
    html = "<div class='breadcrumb'>"
    @category.ancestors.each do |ancestor|
      if ancestor.is_root?
        link = product_types_path
      else
        link = product_type_path(ancestor)
      end
      html << link_to(ancestor.name, link, :class => "nodename") + " > "
    end
    html << link_to(category.name, category, :class => "nodename current")
    html << "</div>"
    html.html_safe
  end

  def submit_tag_with_image(text, image, classes)
    content_tag(:button, image_tag(image) + " " + text, :type => :submit, :name => "commit", :class => classes)
  end
  
  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end    
      else
        html << "<h5>#{message}</h5>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html.html_safe
  end  
end
