class PagesController < ApplicationController

  def index 
    @horses = Horse.all() 
    @title = "Search"
  end

  def home
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
