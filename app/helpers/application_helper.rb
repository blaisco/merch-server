module ApplicationHelper
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
  
  def add_child_object_link(form, object, type, message = nil)
    type  = type.to_sym
    types = type.to_s.pluralize
    message ||= type.to_s.humanize.downcase
    
    html = render("#{type}_fields", :form => form, type => object.send(types).build, :index => "NEW")
    page = "$('##{types}').append(#{prepared_fields(html)});"
    link_to_function "Add #{message}", page, :class => "add button"
  end
  
  def prepared_fields(html)
    "'#{escape_javascript(html)}'.replace(/NEW/g, new Date().getTime())"
  end
end
