class PlayersController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  #--------------
  def show
    @player = Player.find(params[:id])
    @feed_items = @player.microposts.paginate(  :page => params[:page],
                                                :per_page => 10 )
    @micropost = @player.microposts.new
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
      flash[:success] = t('flash.player.created')
      redirect_to( @player )
    else
      flash[:failure] = t('flash.player.nocreate')
      @title = "New Player"
      render 'new'
    end
  end

  #--------------
  def index
    @title = "Players"
    if (params[:search])
      @players = Player.search(params[:search], params[:page])
    else
      @players = Player.paginate(:page => params[:page])
    end
  end

  #--------------
  def edit
    @title = "Edit Player Info"
  end

  #--------------
  def update
    if @player.update_attributes(params[:player])
      flash[:success] = t('flash.player.updated')
      redirect_to @player
    else
      flash[:failure] = t('flash.player.noupdate') 
      @title = "Edit Info"
      render 'edit'
    end
  end

  #--------------
  def destroy
    Player.find( params[:id] ).destroy
    flash[:success] = t('flash.player.deleted')
    redirect_to players_path
  end

  #-------------------------------------------------------------------
  def search
    @players = Player.search parama[:search]
    flash[:failure] = t('flash.player.notfound') if @players.empty? 
  end

  # --------------
  private

  def correct_user 
    @player = Player.find(params[:id])
    redirect_to root_path unless current_user_id?(@player.user_id) 
  end

  def admin_user
    redirect_to( players_path ) unless current_user.admin?
  end

end
