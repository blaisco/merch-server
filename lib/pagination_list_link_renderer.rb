class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected

      def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        tag(:li, link(text, "#"), :class => "disabled")
      end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, @options[:previous_label], 'prev')
    end
    
    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page(num, @options[:next_label], 'next')
    end

    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page)))
      else
        tag(:li, link(page, "#"), :class => "active")
      end
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page), :class => classname)
      else
        tag(:li, link(text, "#"), :class => classname + ' disabled')
      end
    end

    def html_container(html)
      tag(:ul, html, container_attributes)
    end

end
