module ApplicationHelper
  
  # return a title based on the page
  def title
    base_title = "GLOO"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
