class HorsesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  #--------------
  def show 
    @horse = Horse.find(params[:id]) 
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
    @horses = Horse.paginate(:page => params[:page])
  end

  #--------------
  def edit
    @title = "Edit Horse Info"
  end

  #--------------
  def update
    @title = "Update Horse Info"
    if @horse.update_attributes(params[:horse])
      flash[:success] = "Profile updated."
      redirect_to @horse 
    else 
      flash[:failure] = "Update failed"
      @title = "Edit Info"
      render 'edit'
    end
  end

  #--------------
  def destroy
    @title = "Delete Horse Info"
    Horse.find( params[:id] ).destroy
    flash[:success] = "Horse Data Removed"
    redirect_to horses_path
  end

  #-------------------------------------------------------------------
  def search
    @horses = Horse.search parama[:searcs]
  end

  # -----------------------------
  private

  def authenticate 
    deny_access unless signed_in?
  end

  def correct_user 
    @horse = Horse.find(params[:id])
    redirect_to root_path unless current_user_id?(@horse.owner_id) 
  end

  def admin_user
    redirect_to(horses_path) unless current_user.admin?
  end

end
