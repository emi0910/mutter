class MaterializeRenderer < MaterializePagination::Rails

  # @return [String] list of pagination links
  def html_container(html)
    option = container_attributes
    option[:class] = ["pagination", option[:class]].join(' ')
    tag :div, tag(:ul, html, option), class: 'row'
  end

  # @return [String] rendered pagination link
  def page_number(page)
    classes = ['waves-effect', ('active' if page == current_page)].join(' ')
    tag :li, link(page, page, :rel => rel_value(page)), class: classes
  end

end
