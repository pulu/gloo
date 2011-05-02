class Page < ActiveRecord::Base
  #----------------------
  def self.search(search)
    if search && search.length > 0
      @horses = Horse.all(:conditions =>['name LIKE ?',"%#{search}%"])
      @players = Player.all(:conditions =>['name LIKE ?',"%#{search}%"])
    else  
      @horses = []
      @players = []
    end
    @pages = @horses + @players
  end

end
