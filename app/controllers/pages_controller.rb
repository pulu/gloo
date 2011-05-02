class PagesController < ApplicationController

  def index 
    @pages = Page.search( params[:search] )
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help 
    @title = "Help"
  end

end
