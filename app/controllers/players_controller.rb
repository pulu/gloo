class PlayersController < ApplicationController

  #--------------
  def show
    @player = Player.find(params[:id])
    @title = @player.name
  end

  #--------------
  def new
    @title = "Players"
    @player = Player.new
  end

  #--------------
  def create
    @title = "Create Player Profile"
    @player = Player.create(params[:player])
    redirect_to( @player )
  end

  #--------------
  def index
    @title = "Players"
    @players = Player.paginate(:page => params[:page])
  end

  #--------------
  def edit
    @title = "Edit Player Info"
    @player = Player.find(params[:id])
  end

  #--------------
  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:success] = "Profile updated."
      redirect_to @player
    else
      flash[:failure] = "Update failed"
      @title = "Edit Info"
      render 'edit'
    end
  end

  #--------------
  def destroy
    Player.find( params[:id] ).destroy
    flash[:success] = "Player Data Removed"
    redirect_to players_path
  end

  #-------------------------------------------------------------------
  def search
    @players = Player.search parama[:search]
  end

end
