module ApplicationHelper

  # Returns the full title 
  def full_title(page_title = '')
    base_title = "ConNextor"
    page_title.empty? ? base_title :  "#{page_title} | #{base_title}"
  end
  
end
