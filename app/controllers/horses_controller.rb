class HorsesController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  #--------------
  def show 
    @horse = Horse.find(params[:id]) 
    @feed_items = @horse.microposts.paginate( :page => params[:page], 
                                              :per_page => 10 )
    @micropost = @horse.microposts.new 
    @title = @horse.name
  end

  #--------------
  def new
    @title = "Add Horse Profile"
    @horse = Horse.new
  end

  #--------------
  def create 
    @title = "Create Horse Info"
    @horse = Horse.create(params[:horse])

    respond_to do |f|
      if @horse.save
        redirect_to( @horse, :notice => 'Created horse info.')
      else 
        render :action => "new"
      end
    end
  end

  #--------------
  def index
    @title = "Horses"
    if ( params[ :search ])
      @horses = Horse.search(params[:search], params[:page])
    else 
      @horses = Horse.paginate(:page => params[:page])
    end
    flash[:failure] = t('flash.horse.notfound') if @horses.length < 1
  end

  #--------------
  def edit
    @title = "Edit Horse Info"
  end

  #--------------
  def update
    @title = "Update Horse Info"
    if @horse.update_attributes(params[:horse])
      flash[:success] = t('flash.horse.updated')
      redirect_to @horse 
    else 
      flash[:failure] = t('flash.horse.noupdate') 
      @title = "Edit Info"
      render 'edit'
    end
  end

  #--------------
  def destroy
    @title = "Delete Horse Info"
    Horse.find( params[:id] ).destroy
    flash[:success] = t('flash.horse.deleted')
    redirect_to horses_path
  end

  #-------------------------------------------------------------------
  private

  def correct_user 
    @horse = Horse.find(params[:id])
    redirect_to root_path unless current_user_id?(@horse.user_id) 
  end

  def admin_user
    redirect_to(horses_path) unless current_user.admin?
  end

end
