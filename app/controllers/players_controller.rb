class PlayersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  #--------------
  def show
    @player = Player.find(params[:id])
    @title = @player.name
  end

  #--------------
  def new
    @title = "New Player"
    @player = Player.new
  end

  #--------------
  def create
    @title = "Create Player Profile"
    if @player = Player.create(params[:player])
      flash[:success] = "Profile created"
      redirect_to( @player )
    else
      flash[:failure] = "Creation Failed"
      @title = "New Player"
      render 'new'
    end
  end

  #--------------
  def index
    @title = "Players"
    @players = Player.paginate(:page => params[:page])
  end

  #--------------
  def edit
    @title = "Edit Player Info"
  end

  #--------------
  def update
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

  # --------------
  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user 
    @player = Player.find(params[:id])
    redirect_to root_path unless current_user_id?(@player.user_id) 
  end

  def admin_user
    redirect_to( players_path ) unless current_user.admin?
  end

end
