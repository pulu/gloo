module ApplicationHelper

  # return a title based on the page
  def title
    base_title = "liquidHorse"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # which controller, and what action
  def category
  end

  # make logo
  def logo
    image_tag("logo.jpg", :alt => "liquidHorse")
  end

end
