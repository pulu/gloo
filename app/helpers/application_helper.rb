module ApplicationHelper
  
  # return a title based on the page
  def title
    base_title = "PULU"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
