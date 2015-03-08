module ApplicationHelper

  # Returns the full title 
  def full_title(page_title = '')
    base_title = "ConNextor"
    page_title.empty? ? base_title :  "#{page_title} | #{base_title}"
  end

  # Given the name of a column, returns the proper link (could be modified
  # to return the CSS too) for sorting the table based on it
  def table_sort(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column_string && sort_direction_string == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
  
end
